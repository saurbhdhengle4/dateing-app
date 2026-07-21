import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  const GetUsersUseCase(this._repository);
  final UserRepository _repository;

  Future<Either<Failure, List<UserEntity>>> call({int count = 20}) {
    return _repository.getUsers(count: count);
  }
}
