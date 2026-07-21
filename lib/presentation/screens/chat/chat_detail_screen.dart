import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Static chat detail screen — UI only per spec.
class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({
    super.key,
    required this.name,
    this.avatarUrl = 'https://randomuser.me/api/portraits/women/44.jpg',
  });

  final String name;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              children: [
                _RelationshipProgress(name: name),
                const SizedBox(height: 16),
                const _TabPills(),
                const SizedBox(height: 16),
                const _LocationCard(),
                const SizedBox(height: 24),
                const _DateDivider(label: 'TODAY'),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "You reacted to $name's About",
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
                _MyBubble(
                  text: "If you're as fun in person as your profile, I'm in.",
                  time: '1:04 PM',
                ),
                const SizedBox(height: 16),
                const _GiftCard(),
              ],
            ),
          ),
          _MessageInputBar(name: name),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 44,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: _circleButton(Icons.arrow_back_ios_new_rounded, size: 15, onTap: () => Navigator.of(context).pop()),
      ),
      title: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              placeholder: (_, val) => Container(width: 40, height: 40, color: AppColors.surfaceMuted),
              errorWidget: (_, val, val2) => Container(width: 40, height: 40, color: AppColors.surfaceMuted),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(6)),
                      child: const Text(
                        'PLATINUM',
                        style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(color: AppColors.online, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    const Text('Online', style: TextStyle(fontSize: 11, color: AppColors.online, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        _circleButton(Icons.call_outlined, onTap: () {}),
        const SizedBox(width: 8),
        _circleButton(Icons.videocam_outlined, onTap: () {}),
        const SizedBox(width: 8),
        _circleButton(Icons.more_vert, onTap: () {}),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _circleButton(IconData icon, {required VoidCallback onTap, double size = 16}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: const BoxDecoration(color: AppColors.coralSoft, shape: BoxShape.circle),
        child: Icon(icon, size: size, color: AppColors.coral),
      ),
    );
  }
}

class _RelationshipProgress extends StatelessWidget {
  const _RelationshipProgress({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'RELATIONSHIP PROGRESS',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.5),
            ),
            const Text(
              'LEVEL 5',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.coral, letterSpacing: 0.5),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: 0.88,
            minHeight: 7,
            backgroundColor: AppColors.surfaceMuted,
            valueColor: const AlwaysStoppedAnimation(AppColors.coral),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.check_circle, size: 15, color: Color(0xFFF5A623)),
            const SizedBox(width: 6),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  children: [
                    const TextSpan(text: 'Milestone reached: '),
                    TextSpan(
                      text: 'Premium Badge unlocked',
                      style: const TextStyle(color: AppColors.coral, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TabPills extends StatelessWidget {
  const _TabPills();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _pill('🎁', 'Gifts', count: '12', selected: true),
          const SizedBox(width: 10),
          _pill('💬', 'Compliments', selected: false),
          const SizedBox(width: 10),
          _pill('📅', 'Date Invites', count: '3', selected: false),
        ],
      ),
    );
  }

  Widget _pill(String emoji, String label, {String? count, required bool selected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.coral : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.textPrimary,
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: selected ? Colors.white.withValues(alpha: 0.25) : AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppTheme.radiusL)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.shield_outlined, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Meet at the venue - your exact location stays private. Have a great date!',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              border: Border.all(color: AppColors.divider),
            ),
            child: const Center(
              child: Icon(Icons.location_on, size: 40, color: AppColors.coral),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: AppColors.coral),
              const SizedBox(width: 4),
              const Text('Blue Tokai', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.coral,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Add to calendar', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.divider),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Get directions', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateDivider extends StatelessWidget {
  const _DateDivider({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
        child: Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.5),
        ),
      ),
    );
  }
}

class _MyBubble extends StatelessWidget {
  const _MyBubble({required this.text, required this.time});
  final String text;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            constraints: const BoxConstraints(maxWidth: 260),
            decoration: BoxDecoration(
              color: AppColors.coral,
              borderRadius: BorderRadius.circular(20).copyWith(bottomRight: const Radius.circular(4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(text, style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.3)),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(time, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 10)),
                    const SizedBox(width: 4),
                    Icon(Icons.done_all, size: 13, color: Colors.white.withValues(alpha: 0.85)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        const CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/12.jpg'),
        ),
      ],
    );
  }
}

class _GiftCard extends StatelessWidget {
  const _GiftCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppTheme.radiusM)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(color: AppColors.coralSoft, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: const Text('🌹', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rose', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Text('🪙', style: TextStyle(fontSize: 11)),
                        const SizedBox(width: 4),
                        const Text('10 coins', style: TextStyle(fontSize: 12, color: AppColors.coral, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.coralSoft, borderRadius: BorderRadius.circular(10)),
                child: const Text('SENT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.coral)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '"A little something to brighten your day 🌹"',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class _MessageInputBar extends StatelessWidget {
  const _MessageInputBar({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            _iconButton(Icons.add),
            const SizedBox(width: 8),
            _iconButton(Icons.image_outlined),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Message $name...', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    ),
                    const Icon(Icons.mic_none_rounded, size: 18, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(color: AppColors.coral, shape: BoxShape.circle),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
      child: Icon(icon, size: 18, color: AppColors.textSecondary),
    );
  }
}
