import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Static swipe-style discover screen. No API calls here per spec —
/// uses placeholder network images purely for layout.
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Discover'), centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(color: AppColors.navySoft),
                    const Center(
                      child: Icon(Icons.image_outlined, size: 60, color: Colors.white24),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Maya, 24', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                          SizedBox(height: 4),
                          Text('Mumbai · 4 km away', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _roundAction(Icons.close_rounded, AppColors.textSecondary, 60),
                const SizedBox(width: 20),
                _roundAction(Icons.favorite_rounded, AppColors.coral, 68),
                const SizedBox(width: 20),
                _roundAction(Icons.star_rounded, const Color(0xFF5FA8FF), 60),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _roundAction(IconData icon, Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Icon(icon, color: color, size: size * 0.42),
    );
  }
}
