import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import 'chat_detail_screen.dart';

/// Static "Messages" list screen — UI only per spec.
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int _selectedFilter = 0;

  static const _filters = ['All', 'Unread', 'Online', 'Nearby', 'Date Ideas'];

  static const _newMatches = [
    _NewMatch(name: 'Sarah', avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg', badge: _MatchBadge.newMatch),
    _NewMatch(name: 'Ariya', avatarUrl: 'https://randomuser.me/api/portraits/women/65.jpg', badge: _MatchBadge.gift),
    _NewMatch(name: 'Liam', avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg', badge: _MatchBadge.none),
    _NewMatch(name: 'Chloe', avatarUrl: 'https://randomuser.me/api/portraits/women/21.jpg', badge: _MatchBadge.video),
    _NewMatch(name: 'Dev', avatarUrl: 'https://randomuser.me/api/portraits/men/75.jpg', badge: _MatchBadge.none),
  ];

  static const _conversations = [
    _Conversation(
      name: 'Aanya',
      age: 25,
      matchPercent: 92,
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      isOnline: true,
      time: '2m',
      preview: "Can't wait to see you tonight at the...",
      progress: 1,
      progressLabel: 'Gift unlocked!',
      progressLabelIcon: '🎁',
      progressLabelColor: AppColors.online,
      unreadCount: 2,
    ),
    _Conversation(
      name: 'Jordan',
      age: 27,
      matchPercent: 88,
      avatarUrl: 'https://randomuser.me/api/portraits/men/54.jpg',
      isOnline: true,
      time: 'Now',
      isTyping: true,
      progress: 18 / 25,
      progressLabel: '18/25 for Premium Rose 🌹',
      progressLabelColor: AppColors.textSecondary,
    ),
    _Conversation(
      name: 'Marcus',
      age: 29,
      matchPercent: 75,
      avatarUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
      isOnline: false,
      time: '1h',
      preview: 'That sounds like an amazing hobby! Ho...',
      progress: 5 / 25,
      progressLabel: '5/25 · Deadline 14h ⏰',
      progressLabelColor: AppColors.error,
    ),
    _Conversation(
      name: 'Elena',
      age: 23,
      matchPercent: 95,
      avatarUrl: 'https://randomuser.me/api/portraits/women/33.jpg',
      isOnline: true,
      time: '3h',
      preview: "You: Hey! I'm heading over now.",
      progress: 22 / 25,
      progressLabel: '22/25 for Silver Ring 💍',
      progressLabelColor: AppColors.textSecondary,
    ),
    _Conversation(
      name: 'Rohan',
      age: 26,
      matchPercent: 81,
      avatarUrl: 'https://randomuser.me/api/portraits/men/41.jpg',
      isOnline: false,
      time: 'Yesterday',
      preview: 'Haha, definitely! Let me know when.',
      progress: 9 / 25,
      progressLabel: '9/25 for Coffee Date ☕',
      progressLabelColor: AppColors.textSecondary,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Messages',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  _circleButton(Icons.settings_outlined, onTap: () {}),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 20, color: AppColors.textSecondary),
                    SizedBox(width: 10),
                    Text('Search matches or messages', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'NEW MATCHES',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.5),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('See all', style: TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
                        SizedBox(width: 2),
                        Icon(Icons.arrow_forward, size: 14, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _newMatches.length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, i) => _NewMatchAvatar(match: _newMatches[i]),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  final selected = i == _selectedFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.coral : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: _conversations.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, i) => _ConversationTile(
                  conversation: _conversations[i],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(
                        name: _conversations[i].name,
                        avatarUrl: _conversations[i].avatarUrl,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, {required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
        child: Icon(icon, size: 20, color: AppColors.textPrimary),
      ),
    );
  }
}

enum _MatchBadge { none, newMatch, gift, video }

class _NewMatch {
  const _NewMatch({required this.name, required this.avatarUrl, required this.badge});
  final String name;
  final String avatarUrl;
  final _MatchBadge badge;
}

class _Conversation {
  const _Conversation({
    required this.name,
    required this.age,
    required this.matchPercent,
    required this.avatarUrl,
    required this.isOnline,
    required this.time,
    required this.progress,
    required this.progressLabel,
    this.progressLabelColor = AppColors.textSecondary,
    this.progressLabelIcon,
    this.preview,
    this.isTyping = false,
    this.unreadCount = 0,
  });

  final String name;
  final int age;
  final int matchPercent;
  final String avatarUrl;
  final bool isOnline;
  final String time;
  final String? preview;
  final bool isTyping;
  final double progress;
  final String progressLabel;
  final String? progressLabelIcon;
  final Color progressLabelColor;
  final int unreadCount;
}

class _NewMatchAvatar extends StatelessWidget {
  const _NewMatchAvatar({required this.match});
  final _NewMatch match;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 58,
                height: 58,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.coral, width: 2),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: match.avatarUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, val) => Container(color: AppColors.surfaceMuted),
                    errorWidget: (_, val, val2) => Container(color: AppColors.surfaceMuted),
                  ),
                ),
              ),
              if (match.badge == _MatchBadge.newMatch)
                Positioned(
                  top: -6,
                  left: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.coral, borderRadius: BorderRadius.circular(6)),
                    child: const Text('NEW', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: Colors.white)),
                  ),
                ),
              if (match.badge == _MatchBadge.gift)
                Positioned(
                  top: -4,
                  right: -4,
                  child: _badgeIcon(Icons.card_giftcard, const Color(0xFFF5A623)),
                ),
              if (match.badge == _MatchBadge.video)
                Positioned(
                  top: -4,
                  right: -4,
                  child: _badgeIcon(Icons.videocam, AppColors.coral),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            match.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _badgeIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)),
      child: Icon(icon, size: 10, color: Colors.white),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.conversation, required this.onTap});
  final _Conversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppTheme.radiusM)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: conversation.avatarUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    placeholder: (_, val) => Container(width: 56, height: 56, color: AppColors.surfaceMuted),
                    errorWidget: (_, val, val2) => Container(width: 56, height: 56, color: AppColors.surfaceMuted),
                  ),
                ),
                if (conversation.isOnline)
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 13,
                      height: 13,
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
                  Row(
                    children: [
                      Text(
                        '${conversation.name}, ${conversation.age}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.textPrimary),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.coralSoft, borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          '${conversation.matchPercent}% Match',
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.coral),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conversation.isTyping ? 'Typing...' : (conversation.preview ?? ''),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: conversation.isTyping ? AppColors.coral : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: conversation.isTyping ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: conversation.progress.clamp(0, 1),
                            minHeight: 5,
                            backgroundColor: AppColors.surfaceMuted,
                            valueColor: const AlwaysStoppedAnimation(AppColors.coral),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${conversation.progressLabelIcon != null ? '${conversation.progressLabelIcon} ' : ''}${conversation.progressLabel}',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: conversation.progressLabelColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(conversation.time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                if (conversation.unreadCount > 0)
                  Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                    child: Text(
                      '${conversation.unreadCount}',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
