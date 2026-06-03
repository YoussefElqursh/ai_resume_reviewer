import 'package:ai_resume_builder/core/router/routes_constants.dart';
import 'package:ai_resume_builder/feature/analysis_result/ui/screens/analysis_result_screen.dart';
import 'package:ai_resume_builder/feature/file_picker/ui/screen/file_picker_screen.dart';
import 'package:ai_resume_builder/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: RoutesConstants.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: RoutesConstants.filePicker,
          builder: (BuildContext context, GoRouterState state) {
            return const FilePickerScreen();
          },
        ),
        GoRoute(
          path: RoutesConstants.analyze,
          builder: (context, state) {
            final data= state.extra as Map<String, dynamic>;
            return AnalysisResultScreen(data: data);
          },
        ),
      ],
    ),
  ],
);
