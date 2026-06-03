import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const PrimaryButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onTap != null;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isEnabled
              ? const Color(0xFF202871)
              : const Color(0xFFA7ACD7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
