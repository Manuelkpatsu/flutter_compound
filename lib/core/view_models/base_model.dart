import 'package:flutter/material.dart';
import 'package:fluttercompoundapp/core/models/user.dart';
import 'package:fluttercompoundapp/core/services/authentication_service.dart';

import '../../locator.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  AuthUser get currentUser => _authenticationService.currentUser;
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
