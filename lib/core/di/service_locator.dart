import 'package:get_it/get_it.dart';

import '../../data/repository.dart';
import '../api_client.dart';

final sl = GetIt.instance; // service locator

void setupLocator() {
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => AuthRepository(sl()));
}
