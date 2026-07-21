import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/user_entity.dart';
import 'profile_mock_data.dart';

/// Full-bleed profile card used in the Home swipe deck.
///
/// [likeOpacity]/[nopeOpacity] drive the LIKE/NOPE stamps while the card
/// is being dragged (0 = hidden, 1 = fully visible). [showControls] is
/// turned off for the cards stacked *behind* the active one, since they
/// aren't interactive yet.
class SwipeProfileCard extends StatelessWidget {
  const SwipeProfileCard({
    super.key,
    required this.user,
    this.onTap,
    this.onUndo,
    this.onMore,
    this.onRose,
    this.showControls = true,
    this.likeOpacity = 0,
    this.nopeOpacity = 0,
  });

  final UserEntity user;
  final VoidCallback? onTap;
  final VoidCallback? onUndo;
  final VoidCallback? onMore;
  final VoidCallback? onRose;
  final bool showControls;
  final double likeOpacity;
  final double nopeOpacity;

  @override
  Widget build(BuildContext context) {
    final details = ProfileMockData.forUser(user);

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: user.largePhotoUrl,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(color: AppColors.surfaceMuted),
              errorWidget: (_, _, _) => Container(
                color: AppColors.surfaceMuted,
                child: const Icon(Icons.person, size: 60, color: AppColors.textSecondary),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.45, 1.0],
                    colors: AppColors.cardGradient,
                  ),
                ),
              ),
            ),
            if (showControls)
              Positioned(top: 16, left: 16, child: _circleButton(Icons.replay_rounded, onUndo)),
            if (showControls)
              Positioned(top: 16, right: 16, child: _circleButton(Icons.more_vert_rounded, onMore)),
            Positioned(
              left: 20,
              right: showControls ? 92 : 20,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _Badge(label: '${details.matchPercent}% Match', color: const Color(0xFF5FA8FF)),
                      _Badge(label: '${details.trustPercent}% Trust', color: const Color(0xFF37C46B)),
                      _Badge(label: details.replyLabel, color: const Color(0xFFE6A93A)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (user.isOnline) ...[
                        Container(
                          width: 9,
                          height: 9,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(color: AppColors.online, shape: BoxShape.circle),
                        ),
                      ],
                      Flexible(
                        child: Text(
                          '${user.firstName} ${user.age}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                        ),
                      ),
                      if (details.verified) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(color: AppColors.coral, shape: BoxShape.circle),
                          child: const Icon(Icons.check_rounded, size: 12, color: Colors.white),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  _infoRow(Icons.location_on_rounded, '${user.city} · ${details.distanceKm} km away'),
                  const SizedBox(height: 2),
                  _infoRow(Icons.work_outline_rounded, '${details.occupation} · ${details.heightLabel}'),
                  const SizedBox(height: 2),
                  _infoRow(Icons.favorite_rounded, details.lookingFor),
                ],
              ),
            ),
            if (showControls)
              Positioned(
                right: 18,
                bottom: 24,
                child: _RoseButton(onTap: onRose),
              ),
            if (nopeOpacity > 0)
              Positioned(
                top: 48,
                left: 24,
                child: Opacity(
                  opacity: nopeOpacity,
                  child: const _StampBadge(text: 'NOPE', color: Color(0xFFE85C4A), angle: -0.35),
                ),
              ),
            if (likeOpacity > 0)
              Positioned(
                top: 48,
                right: 24,
                child: Opacity(
                  opacity: likeOpacity,
                  child: const _StampBadge(text: 'LIKE', color: Color(0xFF37C46B), angle: 0.35),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.white70),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _circleButton(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Icon(icon, size: 18, color: AppColors.navy),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _RoseButton extends StatelessWidget {
  const _RoseButton({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: AppColors.coral.withValues(alpha: 0.6), blurRadius: 18, spreadRadius: 1),
          ],
        ),
        alignment: Alignment.center,
        child: const Text('🌹', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class _StampBadge extends StatelessWidget {
  const _StampBadge({required this.text, required this.color, required this.angle});
  final String text;
  final Color color;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white.withValues(alpha: 0.15),
        ),
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: 1.5),
        ),
      ),
    );
  }
}
