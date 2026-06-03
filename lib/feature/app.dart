import 'package:ai_resume_builder/core/router/app_router.dart';
import 'package:ai_resume_builder/core/theme/app_theme.dart';
import 'package:ai_resume_builder/core/theme/theme_cubit.dart';
import 'package:ai_resume_builder/feature/file_picker/cubit/analysis_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<AnalysisCubit>(create: (_) => AnalysisCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: 'ATS Resume Builder',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
