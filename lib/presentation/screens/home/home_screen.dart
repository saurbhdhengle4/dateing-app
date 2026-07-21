import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/user_entity.dart';
import '../../bloc/home/home_bloc.dart';
import '../../widgets/app_error_view.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/home_loading_skeleton.dart';
import '../../widgets/home_top_bar.dart';
import '../../widgets/online_avatar.dart';
import '../../widgets/section_header.dart';
import '../../widgets/swipe/swipe_card_deck.dart';
import '../../widgets/user_card.dart';
import '../../widgets/user_list_tile.dart';
import '../profile/user_detail_screen.dart';

const _kCategories = ['All', 'Nearby', 'New', 'Online'];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openProfile(BuildContext context, UserEntity user) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => UserDetailScreen(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const HomeTopBar(),
      body: SafeArea(
        bottom: false,
        top: false,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.initial || state.isLoading) {
              return const HomeLoadingSkeleton();
            }
            if (state.isFailure && state.users.isEmpty) {
              return AppErrorView(
                message: state.errorMessage ?? 'Something went wrong.',
                onRetry: () => context.read<HomeBloc>().add(const HomeStarted()),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.52,
                    child: _SwipeDeckSection(users: state.users),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.onlineUsers.isNotEmpty) ...[
                          const SectionHeader(title: 'Online Now'),
                          SizedBox(
                            height: 92,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: state.onlineUsers.length,
                              separatorBuilder: (_, _) => const SizedBox(width: 12),
                              itemBuilder: (_, i) => OnlineAvatar(
                                user: state.onlineUsers[i],
                                onTap: () => _openProfile(context, state.onlineUsers[i]),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            children: [
                              for (final category in _kCategories)
                                CategoryChip(
                                  label: category,
                                  selected: state.selectedCategory == category,
                                  onTap: () => context.read<HomeBloc>().add(HomeCategoryChanged(category)),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        SectionHeader(title: 'Recommended', onSeeAll: () {}),
                        SizedBox(
                          height: 260,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: state.filteredUsers.length,
                            separatorBuilder: (_, _) => const SizedBox(width: 14),
                            itemBuilder: (_, i) {
                              final user = state.filteredUsers[i];
                              return UserCard(
                                user: user,
                                onTap: () => _openProfile(context, user),
                                onLike: () => ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Liked ${user.firstName}!')),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SectionHeader(title: 'Nearby you'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              for (final user in state.filteredUsers)
                                UserListTile(
                                  user: user,
                                  onTap: () => _openProfile(context, user),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Hosts the swipeable deck and remembers locally when it has been fully
/// swiped through, so it can offer a "load more" action without the bloc
/// needing to know anything about drag/swipe state.
class _SwipeDeckSection extends StatefulWidget {
  const _SwipeDeckSection({required this.users});

  final List<UserEntity> users;

  @override
  State<_SwipeDeckSection> createState() => _SwipeDeckSectionState();
}

class _SwipeDeckSectionState extends State<_SwipeDeckSection> {
  bool _exhausted = false;

  @override
  void didUpdateWidget(covariant _SwipeDeckSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldIds = oldWidget.users.map((u) => u.id).toList();
    final newIds = widget.users.map((u) => u.id).toList();
    if (!listEquals(oldIds, newIds)) {
      _exhausted = false;
    }
  }

  void _openProfile(UserEntity user) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => UserDetailScreen(user: user)),
    );
  }

  void _requestMore() => context.read<HomeBloc>().add(const HomeRefreshed());

  @override
  Widget build(BuildContext context) {
    if (widget.users.isEmpty) {
      return AppErrorView(
        message: 'No profiles nearby right now.',
        onRetry: _requestMore,
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SwipeCardDeck(
          users: widget.users,
          onOpenProfile: _openProfile,
          onDeckExhausted: () => setState(() => _exhausted = true),
        ),
        if (_exhausted) _EmptyDeckCard(onRefresh: _requestMore),
      ],
    );
  }
}

class _EmptyDeckCard extends StatelessWidget {
  const _EmptyDeckCard({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite_rounded, size: 44, color: AppColors.coral),
          const SizedBox(height: 16),
          const Text(
            "You're all caught up",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 6),
          const Text(
            'Check back later for new profiles nearby.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.coral,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            child: const Text('Find more people'),
          ),
        ],
      ),
    );
  }
}
