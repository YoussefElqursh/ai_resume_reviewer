import 'dart:io';
import 'package:flutter/material.dart';

class ResumeUploadCard extends StatelessWidget {
  final File? file;
  final VoidCallback onPick;
  final VoidCallback onRemove;
  const ResumeUploadCard({
    super.key,
    this.file,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Upload CV/Resume',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        file == null ? _emptyCard(context) : _selectedCard(context),
      ],
    );
  }

  String _fileSize(File file) {
    final kb = file.lengthSync() / 1024;
    return '${kb.toStringAsFixed(2)} KB';
  }

  Widget _emptyCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor =
        isDark ? const Color(0xFF2E3460) : const Color(0xFFBBC1D1);
    final iconColor =
        isDark ? const Color(0xFF6B7280) : const Color(0xDD9AA6B2);
    final textColor =
        isDark ? const Color(0xFF6B7280) : const Color(0xFF9AA6B2);

    return InkWell(
      onTap: onPick,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1E36) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload_file_rounded, size: 48, color: iconColor),
            const SizedBox(height: 16),
            Text(
              'Tap to upload your CV/Resume',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'PDF, DOC, DOCX supported',
              style: TextStyle(fontSize: 13, color: textColor.withAlpha(180)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor =
        isDark ? const Color(0xFF2A1A1E) : const Color(0xFFFFF2F4);
    final borderColor =
        isDark ? const Color(0xFF5C2D35) : const Color(0xFFD5C2C7);
    final nameColor =
        isDark ? const Color(0xFFE8EAFF) : const Color(0xFF3A3A3A);
    final sizeColor =
        isDark ? const Color(0xFFAAB0D8) : const Color(0xFF7A7A7A);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE53935),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.picture_as_pdf,
                color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file!.path.split('/').last.split('\\').last,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: nameColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'File size: ${_fileSize(file!)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: sizeColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close_rounded,
                color: Color(0xFFE53935), size: 26),
          ),
        ],
      ),
    );
  }
}
