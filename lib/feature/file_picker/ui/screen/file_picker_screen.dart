import 'dart:io';

import 'package:ai_resume_builder/core/router/routes_constants.dart';
import 'package:ai_resume_builder/core/theme/theme_cubit.dart';
import 'package:ai_resume_builder/feature/file_picker/cubit/analysis_cubit.dart';
import 'package:ai_resume_builder/feature/file_picker/cubit/analysis_state.dart';
import 'package:ai_resume_builder/feature/file_picker/ui/widget/primary_button.dart';
import 'package:ai_resume_builder/feature/file_picker/ui/widget/resume_upload_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class FilePickerScreen extends StatelessWidget {
  const FilePickerScreen({super.key});

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null && context.mounted) {
      context.read<AnalysisCubit>().pickFile(File(result.files.single.path!));
    }
  }

  Future<void> _analyzeResume(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Lottie.asset(
          'assets/animations/analysis_animation.json',
          width: 200,
          height: 200,
        ),
      ),
    );

    await context.read<AnalysisCubit>().analyzeResume();

    if (!context.mounted) return;
    context.pop(); // close the dialog

    final state = context.read<AnalysisCubit>().state;
    if (state is AnalysisSuccess) {
      context.push(RoutesConstants.analyze, extra: state.data);
      context.read<AnalysisCubit>().reset();
    } else if (state is AnalysisFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to analyze resume: ${state.message}'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return IconButton(
                tooltip: themeMode == ThemeMode.dark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    themeMode == ThemeMode.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    key: ValueKey(themeMode),
                  ),
                ),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: BlocBuilder<AnalysisCubit, AnalysisState>(
          builder: (context, state) {
            final cubit = context.read<AnalysisCubit>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ResumeUploadCard(
                  onPick: () => _pickFile(context),
                  onRemove: cubit.removeFile,
                  file: cubit.selectedFile,
                ),
                const Spacer(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<AnalysisCubit, AnalysisState>(
            builder: (context, state) {
              final cubit = context.read<AnalysisCubit>();
              return PrimaryButton(
                title: 'Analyze Resume',
                onTap: cubit.selectedFile == null ? null : () => _analyzeResume(context),
              );
            },
          ),
        ),
      ),
    );
  }
}