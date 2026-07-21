import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../swipe/profile_mock_data.dart';

/// Shared building blocks for the "about + basics" profile UI, used by
/// both the full [UserDetailScreen] and the Home swipe deck's inline
/// preview of the top card.

Widget sectionLabel(String text) {
  return Text(
    text,
    style: const TextStyle(color: AppColors.coral, fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 0.4),
  );
}

/// Pins a small decorative marker to the bottom-right corner of a card,
/// hanging half off its edge — matches the reference design's "pinned"
/// treatment on photos, prompts, and text cards.
Widget withPin(Widget card) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      card,
      Positioned(
        right: 14,
        bottom: -12,
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 6, offset: const Offset(0, 2))],
          ),
          child: const Icon(Icons.push_pin_rounded, size: 14, color: AppColors.coral),
        ),
      ),
    ],
  );
}

/// Match / Trust / Reply badge row shown at the top of a profile.
class MatchBadgeRow extends StatelessWidget {
  const MatchBadgeRow({super.key, required this.match});

  final ProfileMockData match;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ProfileBadge(label: '${match.matchPercent}% Match', color: const Color(0xFF5FA8FF)),
        ProfileBadge(label: '${match.trustPercent}% Trust', color: const Color(0xFF37C46B)),
        ProfileBadge(label: match.replyLabel, color: const Color(0xFFE6A93A)),
      ],
    );
  }
}

class ProfileBadge extends StatelessWidget {
  const ProfileBadge({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

/// Plain paragraph in a rounded card — used for ABOUT.
class AboutCard extends StatelessWidget {
  const AboutCard({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppTheme.radiusM)),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, height: 1.5),
      ),
    );
  }
}

class ProfileInfoRow {
  const ProfileInfoRow({required this.icon, required this.label, required this.value, this.subvalue, this.last = false});
  final IconData icon;
  final String label;
  final String value;
  final String? subvalue;
  final bool last;
}

/// Rounded card listing labeled rows (e.g. Age, Height, Lives in…).
class ProfileInfoBox extends StatelessWidget {
  const ProfileInfoBox({super.key, required this.rows});
  final List<ProfileInfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppTheme.radiusM)),
      child: Column(children: [for (final row in rows) _buildRow(row)]),
    );
  }

  Widget _buildRow(ProfileInfoRow row) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: row.last ? null : const Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(row.icon, size: 18, color: AppColors.coral),
          const SizedBox(width: 12),
          Expanded(child: Text(row.label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(row.value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              if (row.subvalue != null) ...[
                const SizedBox(height: 2),
                Text(row.subvalue!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
