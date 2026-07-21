import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/user_entity.dart';
import '../../bloc/home/home_bloc.dart';
import '../../widgets/app_error_view.dart';
import '../../widgets/home_loading_skeleton.dart';
import '../../widgets/home_top_bar.dart';
import '../../widgets/profile/profile_info_widgets.dart';
import '../../widgets/swipe/profile_detail_data.dart';
import '../../widgets/swipe/profile_mock_data.dart';
import '../../widgets/swipe/swipe_card_deck.dart';
import '../profile/user_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                onRetry: () =>
                    context.read<HomeBloc>().add(const HomeStarted()),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.75,
                      child: _SwipeDeckSection(users: state.users),
                    ),
                  ),
                  if (state.users.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                      child: _ProfileHighlightSection(user: state.users.first),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

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
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => UserDetailScreen(user: user)));
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text('Find more people'),
          ),
        ],
      ),
    );
  }
}

/// Badges + ABOUT + THE BASICS preview for the top card in the deck,
/// shown below the swipe deck so key details are visible without a tap.
class _ProfileHighlightSection extends StatelessWidget {
  const _ProfileHighlightSection({required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final match = ProfileMockData.forUser(user);
    final detail = ProfileDetailData.forUser(user);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MatchBadgeRow(match: match),
        const SizedBox(height: 20),
        sectionLabel('ABOUT'),
        const SizedBox(height: 8),
        withPin(AboutCard(text: detail.about)),
        const SizedBox(height: 24),
        sectionLabel('THE BASICS'),
        const SizedBox(height: 8),
        ProfileInfoBox(
          rows: [
            ProfileInfoRow(icon: Icons.cake_outlined, label: 'Age', value: '${user.age} years old'),
            ProfileInfoRow(icon: Icons.straighten_rounded, label: 'Height', value: detail.heightLabel),
            ProfileInfoRow(icon: Icons.location_on_outlined, label: 'Lives in', value: user.city, subvalue: user.country),
            ProfileInfoRow(icon: Icons.favorite_outline_rounded, label: 'Love language', value: detail.loveLanguage),
            ProfileInfoRow(icon: Icons.self_improvement_rounded, label: 'Religion', value: detail.religion),
            ProfileInfoRow(icon: Icons.wc_rounded, label: 'Interested in', value: detail.interestedIn),
            ProfileInfoRow(icon: Icons.auto_awesome_rounded, label: 'Zodiac', value: detail.zodiacSign, subvalue: detail.zodiacTraits),
            ProfileInfoRow(icon: Icons.translate_rounded, label: 'Mother tongue', value: detail.motherTongue),
            ProfileInfoRow(icon: Icons.chat_bubble_outline_rounded, label: 'Communication style', value: detail.communicationStyle, last: true),
          ],
        ),
      ],
    );
  }
}
