import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _menu = [
    (Icons.person_outline_rounded, 'Edit Profile'),
    (Icons.notifications_none_rounded, 'Notifications'),
    (Icons.lock_outline_rounded, 'Privacy'),
    (Icons.card_giftcard_outlined, 'My Gifts'),
    (Icons.help_outline_rounded, 'Help & Support'),
    (Icons.logout_rounded, 'Log out'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 8),
            Center(
              child: Column(
                children: [
                  const CircleAvatar(radius: 44, backgroundColor: AppColors.surfaceMuted, child: Icon(Icons.person, size: 40, color: AppColors.textSecondary)),
                  const SizedBox(height: 12),
                  Text('Your Name, 24', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  const Text('Pune, Maharashtra', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            for (final item in _menu)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: Icon(item.$1, color: AppColors.navy),
                  title: Text(item.$2, style: const TextStyle(fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                  onTap: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}
