# 🤖 ATS Resume Builder & Analyzer

An intelligent, AI-powered Resume Analyzer and ATS Checker built with **Flutter** (frontend) and **Node.js/Express** (backend). This application parses uploaded PDF resumes and leverages advanced Large Language Models (LLMs) via the **Groq API** to provide instant candidate feedback, ATS compatibility scores, skill gap identification, and targeted career recommendations.

---

## ✨ Features

### 📱 Frontend (Flutter Client)
- **Modern UI/UX**: Sleek design featuring smooth animations, custom upload indicators, and dynamic progress loaders.
- **File Upload**: Native file picking capability supporting `.pdf`, `.doc`, and `.docx` formats.
- **Visual Feedback**: Interactive ATS score speedometer/circular indicators.
- **Categorized Improvements**: Segmented tabs highlighting candidate strengths, skill gaps, and precise improvements across Contact Info, Profile, Employment History, Education, Skills, and Achievements.

### ⚙️ Backend (Express Server)
- **Resilient PDF Parsing**: Extracts raw text from uploaded documents using a version-agnostic PDF parser interface.
- **LLM Integration**: Interfaces with Groq's high-speed `llama-3.3-70b-versatile` model.
- **Smart JSON Sanitization**: Ensures structured, valid JSON outputs with key alignment.
- **Resilient Field Mapping**: Seamlessly normalizes varying LLM response formats (such as fallback mappings for `ats_score` -> `score` and `work_experience` -> `employment_history`) to prevent client-side crashes.

---

## 📂 Project Structure

```
ai_resume_builder/
├── lib/                     # Flutter Client source code
│   ├── core/                # Theme, API Client, Routes, Shared Utilities
│   └── feature/             # Splash Screen, File Picker UI, and Analysis Result screens
├── server/                  # Node.js Express Backend
│   ├── uploads/             # Temporary folder for file uploads
│   ├── .env                 # Environment variables (API Keys & Ports)
│   ├── index.js             # Express Server logic & Groq integration
│   └── package.json         # Node.js dependencies
└── README.md
```

---

## 🚀 Getting Started

Follow these steps to set up and run the project locally.

### 1. Backend Server Setup
1. Navigate to the server folder:
   ```bash
   cd server
   ```
2. Install the Node.js packages:
   ```bash
   npm install
   ```
3. Create a `.env` file in the `server` directory and add your Groq API Key:
   ```env
   GROQ_API_KEY=your_actual_groq_api_key_here
   PORT=5001
   ```
4. Start the backend:
   ```bash
   npm run dev
   ```
   The console will output: `Server is running on port 5001`.

### 2. Frontend Flutter Client Setup
1. Ensure you have the Flutter SDK installed and an emulator (or physical device) connected.
2. In the project root directory, run:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

> [!TIP]
> **Android Emulator Loopback**: The client is configured to automatically route API calls to `10.0.2.2:5001` on Android Emulators, and fallback to `localhost:5001` on other platforms (iOS simulator, Web, etc.).

---

## 🛠️ Tech Stack

- **Frontend**: Flutter, GoRouter, File Picker, HTTP, Lottie Animations.
- **Backend**: Express, Cors, Multer, Axios, PDF-Parse.
- **AI Models**: Groq API (`llama-3.3-70b-versatile`).
