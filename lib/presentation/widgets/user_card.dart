import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/user_entity.dart';

/// Big card used in the "Recommended" feed: full-bleed photo, dark
/// gradient at the bottom, name/age + location, online dot and a
/// like button in the top-right corner.
class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    this.onTap,
    this.onLike,
    this.width = 200,
    this.height = 260,
  });

  final UserEntity user;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: user.largePhotoUrl,
                fit: BoxFit.cover,
                placeholder: (_, val) => Container(color: AppColors.surfaceMuted),
                errorWidget: (_, val, val2) => Container(
                  color: AppColors.surfaceMuted,
                  child: const Icon(Icons.person, size: 40, color: AppColors.textSecondary),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: height * 0.55,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppColors.cardGradient,
                    ),
                  ),
                ),
              ),
              if (user.isOnline)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.online,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onLike,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border_rounded, size: 16, color: AppColors.coral),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                right: 14,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName}, ${user.age}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: Colors.white70),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            user.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
