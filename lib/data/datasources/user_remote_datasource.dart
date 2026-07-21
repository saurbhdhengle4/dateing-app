import '../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers({int count = 20});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<List<UserModel>> getUsers({int count = 20}) async {
    final response = await _client.get<Map<String, dynamic>>(
      '',
      queryParameters: {'results': count},
    );
    final results = (response.data?['results'] as List<dynamic>? ?? []);
    return [
      for (var i = 0; i < results.length; i++)
        UserModel.fromJson(results[i] as Map<String, dynamic>, i),
    ];
  }
}
