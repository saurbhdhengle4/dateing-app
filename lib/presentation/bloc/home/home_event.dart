part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

/// Initial load — shows full-screen loading state.
class HomeStarted extends HomeEvent {
  const HomeStarted();
}

/// Pull-to-refresh — keeps existing list visible while refetching.
class HomeRefreshed extends HomeEvent {
  const HomeRefreshed();
}

/// Simple category filter chip (All / Nearby / New / Online).
class HomeCategoryChanged extends HomeEvent {
  const HomeCategoryChanged(this.category);
  final String category;

  @override
  List<Object?> get props => [category];
}
