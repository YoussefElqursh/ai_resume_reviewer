import express from 'express';
import cors from 'cors';
import multer from 'multer';
import dotenv from 'dotenv';
import fs from 'fs';
import axios from 'axios';
import { createRequire } from 'module';

const require = createRequire(import.meta.url);
const pdfModule = require('pdf-parse');

// Resilient helper to parse PDF depending on which version of pdf-parse is installed
async function parsePdf(fileBuffer) {
    if (typeof pdfModule === 'function') {
        // Original pdf-parse package (v1.x)
        const data = await pdfModule(fileBuffer);
        return data.text || "";
    } else if (pdfModule && typeof pdfModule.PDFParse === 'function') {
        // Mehmet-kozan's pdf-parse package (v2.x)
        const parser = new pdfModule.PDFParse({ data: fileBuffer });
        const data = await parser.getText();
        return data.text || "";
    } else {
        throw new Error('Unsupported pdf-parse library exports. Please check your dependencies.');
    }
}

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const uploadDir = 'uploads/';

if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir);
}

const upload = multer({ dest: uploadDir });

app.get('/', (req, res) => {
    res.send('Hello friend! This is the backend server for the PDF summarizer app. Please use the /upload endpoint to upload your PDF files.');
});

app.post('/analyze-resume', upload.single('file'), async (req, res) => {
    let filePath = null;
    try {
        if (!req.file) {
            return res.status(400).json({ error: 'No file uploaded.' });
        }
        filePath = req.file.path;
        const fileBuffer = fs.readFileSync(filePath);
        const text = await parsePdf(fileBuffer);

        // Truncate text to keep within safe LLM prompt limits if extremely large,
        // but 3500 words/chars might be too short for complete resumes. Let's make it 8000 characters.
        const truncatedText = text.substring(0, 10000);

        console.log(`Analyzing resume text (${truncatedText.length} characters)...`);

        const response = await axios.post(
            'https://api.groq.com/openai/v1/chat/completions',
            {
                model: 'llama-3.3-70b-versatile',
                messages: [
                    {
                        role: 'system',
                        content: 'You are an expert assistant, career coach, and ATS Resume Analyzer. Analyze the resume and provide a structured assessment of the candidate\'s skills, experience, and qualifications.'
                    },
                    {
                        role: 'user',
                        content: `Analyze this resume and respond ONLY in JSON format. Do not write any explanations before or after the JSON.
                        
                        Desired JSON output schema:
                        {
                            "name": "Candidate's Full Name",
                            "score": 85, // ATS score as an integer between 0 and 100
                            "overview": {
                                "strengths": ["list strength 1", "list strength 2"],
                                "skill_gaps": ["list gap 1", "list gap 2"]
                            },
                            "improvements": {
                                "contact_information": ["improvement 1", "improvement 2"],
                                "profile": ["improvement 1", "improvement 2"],
                                "employment_history": ["improvement 1", "improvement 2"],
                                "education": ["improvement 1", "improvement 2"],
                                "skills": ["improvement 1", "improvement 2"],
                                "achievements": ["improvement 1", "improvement 2"]
                            }
                        }

                        Resume Content:
                        ${truncatedText}`
                    }
                ],
                max_tokens: 1500,
                temperature: 0.2
            },
            {
                headers: {
                    Authorization: `Bearer ${process.env.GROQ_API_KEY}`,
                    'Content-Type': 'application/json',
                },
                timeout: 60000,
            }
        );

        const analysis = response.data.choices[0].message.content;

        console.log('RAW AI RESPONSE:');
        console.log(analysis);

        let parsedAnalysis = {};

        try {
            const jsonStartIndex = analysis.indexOf('{');
            const jsonEndIndex = analysis.lastIndexOf('}') + 1;
            if (jsonStartIndex === -1 || jsonEndIndex === -1) {
                throw new Error('No JSON object found in the AI response.');
            } else {
                const jsonString = analysis.substring(jsonStartIndex, jsonEndIndex);
                parsedAnalysis = JSON.parse(jsonString);
            }
        } catch (parseError) {
            console.error('Error parsing AI response:', parseError);
            throw new Error('Failed to parse AI response as JSON.');
        }

        // Resilient Key Mapping to ensure client compatibility
        if (parsedAnalysis.ats_score !== undefined && parsedAnalysis.score === undefined) {
            parsedAnalysis.score = parsedAnalysis.ats_score;
        }
        
        if (!parsedAnalysis.improvements) {
            parsedAnalysis.improvements = {};
        }

        const improvementKeys = [
            'contact_information',
            'profile',
            'employment_history',
            'education',
            'skills',
            'achievements'
        ];

        // Map work_experience -> employment_history if present
        if (parsedAnalysis.improvements.work_experience && !parsedAnalysis.improvements.employment_history) {
            parsedAnalysis.improvements.employment_history = parsedAnalysis.improvements.work_experience;
        }

        // Ensure all expected improvement list fields are present (at least as empty arrays)
        for (const key of improvementKeys) {
            if (!parsedAnalysis.improvements[key]) {
                parsedAnalysis.improvements[key] = [];
            }
        }

        console.log('PARSED & NORMALIZED ANALYSIS:');
        console.log(parsedAnalysis);

        // Delete uploaded file after analysis
        if (fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
        }

        // Return parsed JSON directly
        res.json(parsedAnalysis);

    } catch (error) {
        console.error('Error in /analyze-resume endpoint:', error);
        if (error.response) {
            console.error('Response details:', error.response.data);
        }

        if (filePath && fs.existsSync(filePath)) {
            fs.unlinkSync(filePath);
        }
        res.status(500).json({ error: error.message || 'An error occurred while analyzing the resume.' });
    }
});

const PORT = process.env.PORT || 5001;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
