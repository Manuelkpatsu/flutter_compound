import 'package:fluttercompoundapp/constants/route_names.dart';
import 'package:fluttercompoundapp/core/services/authentication_service.dart';
import 'package:fluttercompoundapp/core/services/navigation_service.dart';

import '../../locator.dart';
import 'base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(homeViewRoute);
    } else {
      _navigationService.navigateTo(loginViewRoute);
    }
  }
}
