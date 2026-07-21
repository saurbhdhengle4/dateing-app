import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Row-style card used for "Nearby you" / list sections lower on
/// the Home screen: thumbnail, name/age, location, online dot.
class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.user, this.onTap});

  final dynamic user; // UserEntity
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: user.thumbnailUrl as String,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    placeholder: (_, val) => Container(color: AppColors.surfaceMuted, width: 56, height: 56),
                    errorWidget: (_, val, val1) => Container(color: AppColors.surfaceMuted, width: 56, height: 56),
                  ),
                ),
                if (user.isOnline as bool)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.online,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.firstName}, ${user.age}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.location as String,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: AppColors.surfaceMuted, shape: BoxShape.circle),
              child: const Icon(Icons.favorite_border_rounded, size: 16, color: AppColors.coral),
            ),
          ],
        ),
      ),
    );
  }
}
