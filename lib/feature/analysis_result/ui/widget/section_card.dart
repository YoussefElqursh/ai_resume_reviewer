import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final List<String> points;
  const SectionCard({super.key, required this.title, required this.points});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(bottom: 20),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Divider(),
          ...points.map(
            (point) => Padding(
              padding: const EdgeInsetsGeometry.only(bottom: 18),
              child: Row(
                children: [
                  const Text("* "),
                  Expanded(child: Text(point)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
