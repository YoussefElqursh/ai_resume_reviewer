import 'package:equatable/equatable.dart';

abstract class AnalysisState extends Equatable {
  const AnalysisState();

  @override
  List<Object?> get props => [];
}

class AnalysisInitial extends AnalysisState {
  const AnalysisInitial();
}

class AnalysisLoading extends AnalysisState {
  const AnalysisLoading();
}

class AnalysisSuccess extends AnalysisState {
  final Map<String, dynamic> data;
  const AnalysisSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class AnalysisFailure extends AnalysisState {
  final String message;
  const AnalysisFailure(this.message);

  @override
  List<Object?> get props => [message];
}
