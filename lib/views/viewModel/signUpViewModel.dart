import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../core/di/service_locator.dart';
import '../../data/repository.dart';

class SignUpViewModel extends StateNotifier<AsyncValue<String?>> {
  SignUpViewModel(this.repo) : super(const AsyncData(null));
  final AuthRepository repo;

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

final authProvider =
    StateNotifierProvider<SignUpViewModel, AsyncValue<String?>>(
      (ref) => SignUpViewModel(sl<AuthRepository>()),
    );
