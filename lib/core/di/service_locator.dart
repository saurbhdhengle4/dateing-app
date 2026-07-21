import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../../presentation/bloc/home/home_bloc.dart';
import '../../presentation/bloc/navigation/nav_cubit.dart';

final sl = GetIt.instance;

/// Wires up the dependency graph once at app startup.
/// Call this before runApp().
void setupServiceLocator() {
  // Core
  sl.registerLazySingleton(() => ApiClient());

  // Data
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl()),
  );

  // Domain
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));

  // Presentation
  sl.registerFactory(() => HomeBloc(sl()));
  sl.registerLazySingleton(() => NavCubit());
}
