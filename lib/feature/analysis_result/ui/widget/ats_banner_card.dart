import 'package:flutter/material.dart';

class AtsBannerCard extends StatelessWidget {
  final String name;
  final int score;
  const AtsBannerCard({super.key, required this.name, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFD7E0EB),),
      ),
      child: Column(
        children: [
          Icon(Icons.description, size: 48, color: Color(0xFF202971)),
          SizedBox(height: 12),
          Text(
            'Applicant Tracking System',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Divider(height: 32),
          Text(
            name,
            style: TextStyle(color: Color(0xFF8A8FB9)),
          ),
          SizedBox(height: 4),
          Text(
            'ATS Score: $score%',
          style: TextStyle(fontSize: 16,color: Color(0xFF8A8FB9), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text("Uploaded on Feb 22, 2026",
          style: TextStyle(color: Color(0xFF8A8FB9)),
          ),
        ],
      ),
    );
  }
}
