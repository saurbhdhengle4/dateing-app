import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../root_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RootShell()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(color: AppColors.coral, shape: BoxShape.circle),
              child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 34),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: AppColors.coral, strokeWidth: 2),
          ],
        ),
      ),
    );
  }
}
