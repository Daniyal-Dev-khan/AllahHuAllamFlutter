import 'package:dio/dio.dart';

import '../core/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<Response> login(String email, String password, String fcm) async {
    return await apiClient.dio.post(
      'auth/login',
      data: {
        'email': email,
        'password': password,
        'deviceToken': fcm,
        'deviceType': 'android',
      },
    );
  }

  Future<Response> signUp(
    String name,
    String email,
    String password,
    String deviceId,
  ) async {
    return await apiClient.dio.post(
      'auth/sign-up',
      data: FormData.fromMap({
        'fullName': name,
        'email': email,
        'password': password,
        'deviceId': deviceId,
      }),
      options: Options(headers: {'Accept': 'application/json'}),
    );
  }
}
