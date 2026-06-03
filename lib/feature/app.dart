import 'package:ai_resume_builder/core/router/app_router.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart' show AppTheme;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'ATS Resume Builder',
      theme: AppTheme.lightTheme,
    );
  }
}
