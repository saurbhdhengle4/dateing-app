import 'package:flutter_bloc/flutter_bloc.dart';

/// Controls which tab of the bottom navigation bar is active.
/// 0: Home, 1: Discover, 2: Matches/Likes, 3: Chat, 4: Profile
class NavCubit extends Cubit<int> {
  NavCubit() : super(0);

  void changeTab(int index) => emit(index);
}
