import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Date Now'), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
            
          ],
        ),
      ),
    );
  }
}
