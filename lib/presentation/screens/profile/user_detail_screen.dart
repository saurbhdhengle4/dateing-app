import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/user_entity.dart';
import '../../widgets/profile/profile_info_widgets.dart';
import '../../widgets/swipe/profile_detail_data.dart';
import '../../widgets/swipe/profile_mock_data.dart';

/// Full profile detail screen shown when tapping a card from Home.
/// Static UI only, per the assignment spec — no API calls here
/// beyond the entity already fetched on Home. Match/Trust/Reply and
/// occupation are derived the same way as the swipe card so both
/// screens agree on a given profile.
class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final match = ProfileMockData.forUser(user);
    final detail = ProfileDetailData.forUser(user);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 420,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: _circleBtn(context, Icons.arrow_back_ios_new_rounded, () => Navigator.pop(context)),
            actions: [_circleBtn(context, Icons.more_horiz_rounded, () {})],
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: user.largePhotoUrl,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) => Container(color: AppColors.surfaceMuted),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (user.isOnline)
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.online, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Text('${user.fullName}, ${user.age}', style: Theme.of(context).textTheme.headlineSmall),
                      if (match.verified) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(color: AppColors.coral, shape: BoxShape.circle),
                          child: const Icon(Icons.check_rounded, size: 13, color: Colors.white),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('${user.location} · ${match.distanceKm} km away', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  MatchBadgeRow(match: match),
                  const SizedBox(height: 24),

                  sectionLabel('ABOUT'),
                  const SizedBox(height: 8),
                  withPin(AboutCard(text: detail.about)),
                  const SizedBox(height: 24),

                  sectionLabel('THE BASICS'),
                  const SizedBox(height: 8),
                  ProfileInfoBox(rows: [
                    ProfileInfoRow(icon: Icons.cake_outlined, label: 'Age', value: '${user.age} years old'),
                    ProfileInfoRow(icon: Icons.straighten_rounded, label: 'Height', value: detail.heightLabel),
                    ProfileInfoRow(icon: Icons.location_on_outlined, label: 'Lives in', value: user.city, subvalue: user.country),
                    ProfileInfoRow(icon: Icons.favorite_outline_rounded, label: 'Love language', value: detail.loveLanguage),
                    ProfileInfoRow(icon: Icons.self_improvement_rounded, label: 'Religion', value: detail.religion),
                    ProfileInfoRow(icon: Icons.wc_rounded, label: 'Interested in', value: detail.interestedIn),
                    ProfileInfoRow(icon: Icons.auto_awesome_rounded, label: 'Zodiac', value: detail.zodiacSign, subvalue: detail.zodiacTraits),
                    ProfileInfoRow(icon: Icons.translate_rounded, label: 'Mother tongue', value: detail.motherTongue),
                    ProfileInfoRow(icon: Icons.chat_bubble_outline_rounded, label: 'Communication style', value: detail.communicationStyle, last: true),
                  ]),
                  const SizedBox(height: 16),

                  withPin(_VideoIntroCard(imageUrl: user.largePhotoUrl, duration: detail.videoIntroDuration)),
                  const SizedBox(height: 16),

                  withPin(_PromptCard(label: 'THE WAY TO WIN ME OVER IS…', text: detail.winMeOverPrompt)),
                  const SizedBox(height: 24),

                  sectionLabel('CAREER & AMBITION'),
                  const SizedBox(height: 8),
                  ProfileInfoBox(rows: [
                    ProfileInfoRow(icon: Icons.school_outlined, label: 'Education', value: detail.educationInstitute, subvalue: detail.educationDegree),
                    ProfileInfoRow(icon: Icons.work_outline_rounded, label: 'Work as', value: match.occupation, subvalue: detail.employmentLine),
                    ProfileInfoRow(icon: Icons.auto_fix_high_rounded, label: 'Work style', value: detail.workStyle),
                    ProfileInfoRow(icon: Icons.trending_up_rounded, label: 'Ambition level', value: detail.ambitionLevel, last: true),
                  ]),
                  const SizedBox(height: 16),

                  withPin(_PromptCard(label: 'BIG DREAM', text: detail.bigDream)),
                  const SizedBox(height: 16),

                  withPin(_PhotoTile(imageUrl: user.largePhotoUrl)),
                  const SizedBox(height: 16),

                  withPin(_PromptCard(label: 'MY SIMPLE PLEASURES…', text: detail.simplePleasures)),
                  const SizedBox(height: 24),

                  sectionLabel('INTERESTS & HOBBIES'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [for (final tag in detail.interests) _InterestChip(tag: tag)],
                  ),
                  const SizedBox(height: 24),

                  sectionLabel('LIFESTYLE'),
                  const SizedBox(height: 8),
                  ProfileInfoBox(rows: [
                    ProfileInfoRow(icon: Icons.restaurant_menu_rounded, label: 'Diet', value: detail.diet),
                    ProfileInfoRow(icon: Icons.wine_bar_outlined, label: 'Drinking', value: detail.drinking),
                    ProfileInfoRow(icon: Icons.nightlight_round, label: 'Sleep', value: detail.sleepStyle, last: true),
                  ]),
                  const SizedBox(height: 24),

                  _DatingGoalCard(title: detail.datingGoalTitle, description: detail.datingGoalDescription),
                  const SizedBox(height: 16),

                  withPin(_PhotoTile(imageUrl: user.largePhotoUrl)),
                  const SizedBox(height: 16),

                  withPin(_PromptCard(label: 'WE\'LL GET ALONG IF…', text: detail.getAlongIfPrompt)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _actionCircle(Icons.close_rounded, AppColors.textSecondary, () {}),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.coral,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                  icon: const Icon(Icons.favorite_rounded, size: 18),
                  label: const Text('Send Rose'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleBtn(BuildContext context, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(icon: Icon(icon, size: 16, color: AppColors.navy), onPressed: onTap),
      ),
    );
  }

  Widget _actionCircle(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 26,
        backgroundColor: Colors.white,
        child: Icon(icon, color: color),
      ),
    );
  }
}

/// A labeled "prompt" answer card — a small coral label plus a bold
/// answer (mirrors Hinge-style prompts).
class _PromptCard extends StatelessWidget {
  const _PromptCard({required this.label, required this.text});
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppTheme.radiusM)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.coral, fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: 0.3),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _VideoIntroCard extends StatelessWidget {
  const _VideoIntroCard({required this.imageUrl, required this.duration});
  final String imageUrl;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Video preview not available in this demo')),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) => Container(color: AppColors.surfaceMuted),
              ),
              DecoratedBox(decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.25))),
              const Center(
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.play_arrow_rounded, color: AppColors.navy, size: 28),
                ),
              ),
              Positioned(
                left: 14,
                bottom: 12,
                child: Text(
                  'Video intro · $duration',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.radiusM),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (_, _, _) => Container(color: AppColors.surfaceMuted),
        ),
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({required this.tag});
  final InterestTag tag;

  static const Map<String, IconData> _icons = {
    'Travel': Icons.flight_takeoff_rounded,
    'Coffee': Icons.local_cafe_rounded,
    'Trekking': Icons.terrain_rounded,
    'Books': Icons.menu_book_rounded,
    'Yoga': Icons.self_improvement_rounded,
    'Indie music': Icons.music_note_rounded,
    'Cooking': Icons.restaurant_rounded,
    'Photography': Icons.camera_alt_rounded,
    'Gaming': Icons.sports_esports_rounded,
    'Fitness': Icons.fitness_center_rounded,
    'Movies': Icons.movie_outlined,
    'Dancing': Icons.nightlife_rounded,
    'Art': Icons.palette_outlined,
    'Running': Icons.directions_run_rounded,
    'Wine tasting': Icons.wine_bar_rounded,
    'Gardening': Icons.local_florist_rounded,
    'Cycling': Icons.directions_bike_rounded,
    'Podcasts': Icons.podcasts_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icons[tag.label] ?? Icons.star_outline_rounded, size: 16, color: AppColors.coral),
          const SizedBox(width: 8),
          Text(tag.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _DatingGoalCard extends StatelessWidget {
  const _DatingGoalCard({required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.coral, borderRadius: BorderRadius.circular(AppTheme.radiusM)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DATING GOAL',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, fontSize: 11, letterSpacing: 0.4),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}

