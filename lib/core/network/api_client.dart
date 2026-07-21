import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

/// Thin wrapper around Dio so datasources never talk to Dio directly.
/// Makes it trivial to swap the http client or add interceptors later.
class ApiClient {
  ApiClient() : _dio = Dio(
          BaseOptions(
            baseUrl: AppConstants.randomUserBaseUrl,
            connectTimeout: AppConstants.connectTimeout,
            receiveTimeout: AppConstants.receiveTimeout,
          ),
        );

  final Dio _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get<T>(path, queryParameters: queryParameters);
  }
}
