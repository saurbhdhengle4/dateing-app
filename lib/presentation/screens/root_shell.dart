import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/service_locator.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/navigation/nav_cubit.dart';
import '../screens/chat/chat_list_screen.dart';
import '../screens/discover/discover_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/matches/matches_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../widgets/app_bottom_nav_bar.dart';

class RootShell extends StatelessWidget {
  const RootShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: BlocBuilder<NavCubit, int>(
        bloc: sl<NavCubit>(),
        builder: (context, index) {
          return Scaffold(
            body: IndexedStack(
              index: index,
              children: const [
                HomeScreen(),
                DiscoverScreen(),
                MatchesScreen(),
                ChatListScreen(),
                ProfileScreen(),
              ],
            ),
            bottomNavigationBar: AppBottomNavBar(
              currentIndex: index,
              onTap: (i) => sl<NavCubit>().changeTab(i),
            ),
          );
        },
      ),
    );
  }
}
