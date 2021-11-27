import 'package:fluttercompoundapp/utils/image_selector.dart';
import 'package:get_it/get_it.dart';

import 'core/services/authentication_service.dart';
import 'core/services/cloud_storage_service.dart';
import 'core/services/dialog_service.dart';
import 'core/services/firestore_service.dart';
import 'core/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
}
