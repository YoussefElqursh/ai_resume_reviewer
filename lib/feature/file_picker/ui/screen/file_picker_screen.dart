import 'dart:io';

import 'package:ai_resume_builder/core/api/api_service.dart';
import 'package:ai_resume_builder/core/router/routes_constants.dart';
import 'package:ai_resume_builder/feature/file_picker/ui/widget/primary_button.dart';
import 'package:ai_resume_builder/feature/file_picker/ui/widget/resume_upload_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class FilePickerScreen extends StatefulWidget {
  const FilePickerScreen({super.key});

  @override
  State<FilePickerScreen> createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  File? file;
  Future<void> pickFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf',],
    );
    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    }
  }

  void removeFile() {
    setState(() {
      file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResumeUploadCard(
              onPick: pickFile,
              onRemove: removeFile,
              file: file,
            ),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: PrimaryButton(
            title: 'Analyze Resume',
            onTap: file == null
                ? null
                : () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => Lottie.asset(
                        'assets/animations/analysis_animation.json',
                      ),
                    );
                    try {
                      final result = await ApiService.analyzeResume(file!);
                      if (mounted) {
                        context.pop();
                        context.go(RoutesConstants.analyze, extra: result);
                      }
                    } catch (e) {
                      if (mounted) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to analyze resume'),
                          ),
                        );
                      }
                    }
                  },
          ),
        ),
      ),
    );
  }
}