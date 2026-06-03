import 'package:ai_resume_builder/feature/analysis_result/ui/widget/ats_banner_card.dart';
import 'package:ai_resume_builder/feature/analysis_result/ui/widget/custom_tab_bar.dart';
import 'package:ai_resume_builder/feature/analysis_result/ui/widget/section_card.dart';
import 'package:flutter/material.dart';

class AnalysisResultScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const AnalysisResultScreen({super.key, required this.data});

  @override
  State<AnalysisResultScreen> createState() => _AnalysisResultScreenState();
}

class _AnalysisResultScreenState extends State<AnalysisResultScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    final data = widget.data;
    final name = data['name']?.toString() ?? 'Unknown';
    final score = data['score'] is int ? data['score'] : int.tryParse(data['score'].toString()) ?? 0;
    final overview = Map<String, dynamic>.from(data['overview'] ?? {});
    final strengths = (overview['strengths'] as List?)?.map((e) => e.toString()).toList() ?? [];
    final gaps = (overview['skill_gaps'] as List?)?.map((e) => e.toString()).toList() ?? [];
    final improvements = Map<String,dynamic>.from(data['improvements'] ?? {});


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Applicant Tracking System"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            AtsBannerCard(name: name, score: score,),
            SizedBox(height: 24,),
            CustomTabBar(
              selectedIndex: _selectedIndex,
              onChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            _selectedIndex == 0 ? _overviewTab(strengths, gaps) : _improvementTab(improvements),
          ],
        ),
      ),
    );
  }
}

Widget _overviewTab(List<String> strengths, List<String> gaps) {
  return Column(
    children: [
      SectionCard(title: 'Strengths', points: strengths,),
      SectionCard(title: 'Skill Gaps', points: gaps,),
    ],
  );
}

Widget _improvementTab(Map<String, dynamic> improvements){
  return Column(
    children: [
      SectionCard(title: 'Contact Information', points: List<String>.from(improvements['contact_information'] ?? []),),
      SectionCard(title: 'profile', points: List<String>.from(improvements['profile'] ?? []),),
      SectionCard(title: 'Employment History', points: List<String>.from(improvements['employment_history'] ?? []),),
      SectionCard(title: 'Education', points: List<String>.from(improvements['education'] ?? []),),
      SectionCard(title: 'Skills', points: List<String>.from(improvements['skills'] ?? []),),
      SectionCard(title: 'Achievements', points: List<String>.from(improvements['achievements'] ?? []),),
    ],
  );
}