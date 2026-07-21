import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Static "Admirers" grid screen — likes received. UI only per spec.
class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Admirers'), centerTitle: false),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.72,
        ),
        itemCount: 10,
        itemBuilder: (context, i) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(color: AppColors.navySoft),
              const Center(child: Icon(Icons.favorite, color: Colors.white24, size: 36)),
              Positioned(
                left: 10,
                bottom: 10,
                child: Text('User ${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
