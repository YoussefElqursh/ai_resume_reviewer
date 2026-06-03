import 'package:flutter/material.dart';

class AtsBannerCard extends StatelessWidget {
  final String name;
  final int score;
  const AtsBannerCard({super.key, required this.name, required this.score});

  Color _scoreColor(int score) {
    if (score >= 80) return const Color(0xFF22C55E);
    if (score >= 60) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? const Color(0xFF2E3460) : const Color(0xFFD7E0EB);
    final subtitleColor = isDark ? const Color(0xFFAAB0D8) : const Color(0xFF8A8FB9);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Icon(Icons.description, size: 48, color: theme.primaryColor),
          const SizedBox(height: 12),
          Text(
            'Applicant Tracking System',
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
          ),
          Divider(height: 32, color: borderColor),
          Text(name, style: TextStyle(color: subtitleColor)),
          const SizedBox(height: 4),
          Text(
            'ATS Score: $score%',
            style: TextStyle(
              fontSize: 16,
              color: _scoreColor(score),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Uploaded on ${DateTime.now().day} ${_monthName(DateTime.now().month)} ${DateTime.now().year}',
            style: TextStyle(color: subtitleColor),
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
