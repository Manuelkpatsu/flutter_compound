import 'package:fluttercompoundapp/constants/route_names.dart';
import 'package:fluttercompoundapp/core/services/authentication_service.dart';
import 'package:fluttercompoundapp/core/services/dialog_service.dart';
import 'package:fluttercompoundapp/core/services/navigation_service.dart';

import '../../locator.dart';
import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    required String email,
    required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(homeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result.toString(),
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(signUpViewRoute);
  }
}
