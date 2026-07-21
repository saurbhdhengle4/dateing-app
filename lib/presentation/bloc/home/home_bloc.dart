import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_users_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getUsersUseCase) : super(const HomeState()) {
    on<HomeStarted>(_onStarted);
    on<HomeRefreshed>(_onRefreshed);
    on<HomeCategoryChanged>(_onCategoryChanged);
  }

  final GetUsersUseCase _getUsersUseCase;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await _fetch(emit);
  }

  Future<void> _onRefreshed(HomeRefreshed event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.refreshing));
    await _fetch(emit);
  }

  Future<void> _onCategoryChanged(
    HomeCategoryChanged event,
    Emitter<HomeState> emit,
  ) async {
    final filtered = _applyCategory(state.users, event.category);
    emit(state.copyWith(
      selectedCategory: event.category,
      filteredUsers: filtered,
    ));
  }

  Future<void> _fetch(Emitter<HomeState> emit) async {
    final result = await _getUsersUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: failure.message,
      )),
      (users) {
        final online = users.where((u) => u.isOnline).toList();
        emit(state.copyWith(
          status: HomeStatus.success,
          users: users,
          filteredUsers: _applyCategory(users, state.selectedCategory),
          onlineUsers: online,
          errorMessage: null,
        ));
      },
    );
  }

  List<UserEntity> _applyCategory(List<UserEntity> users, String category) {
    switch (category) {
      case 'Online':
        return users.where((u) => u.isOnline).toList();
      case 'Nearby':
        return users.take(10).toList();
      case 'New':
        return users.reversed.take(10).toList();
      case 'All':
      default:
        return users;
    }
  }
}
