import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Static "Notifications" screen — UI only, no bloc/API wiring.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _filters = ['All', 'Likes & roses', 'Matches', 'Gifts', 'Dates'];

  static final List<_NotificationItem> _items = [
    _NotificationItem(
      avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      badge: _BadgeType.rose,
      title: [
        const _Span('Dev, 27', bold: true),
        const _Span(' sent you a Rose'),
      ],
      quote: "Your trekking photos sold me — let's swap trail stories.",
      time: '12 min ago',
      actionLabel: 'View profile',
      unread: true,
    ),
    _NotificationItem(
      avatarUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
      badge: _BadgeType.comment,
      title: [
        const _Span('Arjun, 28', bold: true),
        const _Span(' complimented your '),
        const _Span('About', bold: true),
      ],
      quote: 'Equally driven and equally curious — that line got me.',
      time: '3 h ago',
      unread: false,
    ),
    _NotificationItem(
      avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
      badge: _BadgeType.match,
      title: [
        const _Span("It's a match with "),
        const _Span('Aanya, 25', bold: true),
      ],
      description: 'You both liked each other. Say hello before the spark fades.',
      time: '40 min ago',
      actionLabel: 'Send a message',
      unread: true,
    ),
    _NotificationItem(
      avatarUrl: 'https://randomuser.me/api/portraits/women/21.jpg',
      badge: _BadgeType.message,
      title: [
        const _Span('Elena, 23', bold: true),
        const _Span(' sent you a message'),
      ],
      quote: 'Haha okay that café pick was elite. When are you free?',
      time: '1 h ago',
      unread: true,
    ),
    _NotificationItem(
      avatarUrl: null,
      badge: _BadgeType.calendar,
      title: [
        const _Span('Kabir', bold: true),
        const _Span(' approved your date request'),
      ],
      description: 'Coffee at Blue Tokai · Today, 7:00 PM · Koregaon Park',
      time: '2 h ago',
      actionLabel: 'Open chat',
      unread: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: _Header(),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  for (var i = 0; i < _filters.length; i++)
                    _FilterChip(
                      label: _filters[i],
                      count: i == 0 ? 56 : null,
                      selected: i == 0,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                children: [
                  const Text(
                    'TODAY',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (var i = 0; i < _items.length; i++) ...[
                    _NotificationCard(item: _items[i]),
                    if (i != _items.length - 1) const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CircleButton(
          icon: Icons.chevron_left_rounded,
          onTap: () => Navigator.of(context).maybePop(),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '9 new updates',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {},
            child: const Text(
              'Mark all read',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.coral,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: AppColors.textPrimary),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, this.count});

  final String label;
  final bool selected;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: selected ? AppColors.navy : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum _BadgeType { rose, comment, match, message, calendar }

class _Span {
  const _Span(this.text, {this.bold = false});
  final String text;
  final bool bold;
}

class _NotificationItem {
  const _NotificationItem({
    required this.avatarUrl,
    required this.badge,
    required this.title,
    required this.time,
    this.quote,
    this.description,
    this.actionLabel,
    this.unread = false,
  });

  final String? avatarUrl;
  final _BadgeType badge;
  final List<_Span> title;
  final String time;
  final String? quote;
  final String? description;
  final String? actionLabel;
  final bool unread;
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final _NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(url: item.avatarUrl, badge: item.badge),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 14.5, color: AppColors.textPrimary, height: 1.3),
                        children: [
                          for (final span in item.title)
                            TextSpan(
                              text: span.text,
                              style: TextStyle(fontWeight: span.bold ? FontWeight.w700 : FontWeight.w400),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (item.quote != null)
                      Text(
                        '"${item.quote}"',
                        style: const TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: AppColors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    if (item.description != null)
                      Text(
                        item.description!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      item.time,
                      style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
                    ),
                    if (item.actionLabel != null) ...[
                      const SizedBox(height: 12),
                      _ActionButton(label: item.actionLabel!),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (item.unread)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: AppColors.coral, shape: BoxShape.circle),
              ),
            ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.badge});

  final String? url;
  final _BadgeType badge;

  static const _size = 56.0;

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: AppColors.coralSoft,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.calendar_month_rounded, color: Color(0xFFE0904D), size: 26),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: url!,
            width: _size,
            height: _size,
            fit: BoxFit.cover,
            placeholder: (_, _) => Container(color: AppColors.surfaceMuted),
            errorWidget: (_, _, _) => Container(color: AppColors.surfaceMuted),
          ),
        ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: _badgeColor(badge),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surface, width: 2),
            ),
            child: Icon(_badgeIcon(badge), size: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  static Color _badgeColor(_BadgeType badge) {
    switch (badge) {
      case _BadgeType.rose:
        return const Color(0xFFEF7FA0);
      case _BadgeType.comment:
        return const Color(0xFFF2A93B);
      case _BadgeType.match:
        return AppColors.online;
      case _BadgeType.message:
        return const Color(0xFFE8536F);
      case _BadgeType.calendar:
        return AppColors.coral;
    }
  }

  static IconData _badgeIcon(_BadgeType badge) {
    switch (badge) {
      case _BadgeType.rose:
        return Icons.local_florist_rounded;
      case _BadgeType.comment:
        return Icons.chat_bubble_rounded;
      case _BadgeType.match:
        return Icons.check_rounded;
      case _BadgeType.message:
        return Icons.chat_bubble_rounded;
      case _BadgeType.calendar:
        return Icons.event_rounded;
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.coral,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
