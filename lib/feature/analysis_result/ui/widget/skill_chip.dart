import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: const Color(0xFF202871))),
    );
  }
}
