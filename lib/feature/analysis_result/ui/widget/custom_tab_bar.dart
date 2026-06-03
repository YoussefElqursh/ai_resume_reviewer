import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;
  const CustomTabBar({super.key, required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab(0,"Overview"),
        _buildTab(1,"Improvement"),
      ],
    );
  }

  Widget _buildTab(int index, String title) {
    final isSelected = index == selectedIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Color(0xFF202871) : Color(0xFF9AA6B2),
              ),
            ),
            SizedBox(height: 4),
            Container(
              height: 3,
              width: isSelected ? 100 : 0,
              color: isSelected ? Color(0xFF202871) : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
