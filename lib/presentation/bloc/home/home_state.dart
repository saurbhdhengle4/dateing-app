part of 'home_bloc.dart';

enum HomeStatus { initial, loading, refreshing, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.users = const [],
    this.filteredUsers = const [],
    this.onlineUsers = const [],
    this.selectedCategory = 'All',
    this.errorMessage,
  });

  final HomeStatus status;
  final List<UserEntity> users;
  final List<UserEntity> filteredUsers;
  final List<UserEntity> onlineUsers;
  final String selectedCategory;
  final String? errorMessage;

  bool get isLoading => status == HomeStatus.loading;
  bool get isRefreshing => status == HomeStatus.refreshing;
  bool get isFailure => status == HomeStatus.failure;
  bool get isSuccess => status == HomeStatus.success;

  HomeState copyWith({
    HomeStatus? status,
    List<UserEntity>? users,
    List<UserEntity>? filteredUsers,
    List<UserEntity>? onlineUsers,
    String? selectedCategory,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      onlineUsers: onlineUsers ?? this.onlineUsers,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        users,
        filteredUsers,
        onlineUsers,
        selectedCategory,
        errorMessage,
      ];
}
