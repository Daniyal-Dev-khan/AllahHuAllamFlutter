import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../core/di/service_locator.dart';
import '../../data/repository.dart';

class LoginViewModel extends StateNotifier<AsyncValue<String?>> {
  LoginViewModel(this.repo) : super(const AsyncData(null));
  final AuthRepository repo;

  Future<void> login(String email, String password, String fcm) async {
    try {
      state = const AsyncValue.loading();
      final response = await repo.login(email, password, fcm);
      state = AsyncValue.data(response.data['token']);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> signUp(
    String name,
    String email,
    String password,
    String deviceId,
  ) async {
    try {
      state = const AsyncValue.loading();
      final response = await repo.signUp(name, email, password, deviceId);
      state = AsyncValue.data(response.data['token']);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

final authProvider = StateNotifierProvider<LoginViewModel, AsyncValue<String?>>(
  (ref) => LoginViewModel(sl<AuthRepository>()),
);
