import 'package:ai_resume_builder/core/router/routes_constants.dart';
import 'package:ai_resume_builder/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToFilePicker();
  }

  Future<void> _navigateToFilePicker() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    context.go(RoutesConstants.filePicker);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(Assets.images.appIcon.path, width: 200, height: 200),
      ),
    );
  }
}
