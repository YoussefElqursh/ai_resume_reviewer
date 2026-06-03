import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;
  const CustomTabBar(
      {super.key, required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab(context, 0, 'Overview'),
        _buildTab(context, 1, 'Improvement'),
      ],
    );
  }

  Widget _buildTab(BuildContext context, int index, String title) {
    final isSelected = index == selectedIndex;
    final theme = Theme.of(context);
    final activeColor = theme.primaryColor;
    final inactiveColor = theme.brightness == Brightness.dark
        ? const Color(0xFF6B7280)
        : const Color(0xFF9AA6B2);

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? activeColor : inactiveColor,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: 3,
                width: isSelected ? 100 : 0,
                decoration: BoxDecoration(
                  color: isSelected ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
