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
    return Column(
      crossAxisAlignment: .center,
      children: [
        Text(
          'Upload CV/Resume',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2A6D),
          ),
        ),
        SizedBox(height: 16),
        file == null ? emptyCard(onPick) : selectedCard(onRemove, file!),
      ],
    );
  }
}

String fileSize(File file) {
  final kb = file.lengthSync() / 1024;
  return '${kb.toStringAsFixed(2)} KB';
}

Widget emptyCard(VoidCallback onPick) {
  return InkWell(
    onTap: onPick,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFBBC1D1), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Icon(Icons.upload_file, size: 48, color: Color(0xDD9AA6B2)),
          SizedBox(height: 16),
          Text(
            'Drag and drop your CV/Resume here',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9AA6B2),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget selectedCard(VoidCallback onRemove, File file) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF2F4),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Color(0xFFD5C2C7), width: 1.5),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE53935),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.picture_as_pdf, color: Colors.white, size: 28),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                file.path.split('/').last,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3A3A3A),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Uploaded file Size${fileSize(file)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF7A7A7A),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onRemove,
          child: Icon(Icons.close, color: Color(0xFFE53935), size: 28),
        ),
      ],
    ),
  );
}
