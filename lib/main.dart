import 'package:blocdemo/core/di/service_locator.dart';
import 'package:blocdemo/core/theme/app_theme.dart';
import 'package:blocdemo/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: SplashScreen(),
    );
  }
}
