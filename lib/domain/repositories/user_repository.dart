import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  /// Fetches [count] random users for the Home screen feed.
  Future<Either<Failure, List<UserEntity>>> getUsers({int count = 20});
}
