import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_resume_builder/core/api/api_service.dart';
import 'package:ai_resume_builder/feature/file_picker/cubit/analysis_state.dart';

class AnalysisCubit extends Cubit<AnalysisState> {
  AnalysisCubit() : super(const AnalysisInitial());

  File? selectedFile;

  void pickFile(File file) {
    selectedFile = file;
    // Just keep state as initial (file picked but not analyzed yet)
    emit(const AnalysisInitial());
  }

  void removeFile() {
    selectedFile = null;
    emit(const AnalysisInitial());
  }

  Future<void> analyzeResume() async {
    if (selectedFile == null) return;
    emit(const AnalysisLoading());
    try {
      final result = await ApiService.analyzeResume(selectedFile!);
      emit(AnalysisSuccess(result));
    } catch (e) {
      emit(AnalysisFailure(e.toString()));
    }
  }

  void reset() {
    selectedFile = null;
    emit(const AnalysisInitial());
  }
}
