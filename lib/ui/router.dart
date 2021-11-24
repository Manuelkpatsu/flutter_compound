import 'package:flutter/material.dart';
import 'package:fluttercompoundapp/constants/route_names.dart';
import 'package:fluttercompoundapp/ui/views/create_post_view.dart';
import 'package:fluttercompoundapp/ui/views/home_view.dart';
import 'package:fluttercompoundapp/ui/views/login_view.dart';
import 'package:fluttercompoundapp/ui/views/signup_view.dart';
import 'package:fluttercompoundapp/ui/views/startup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case startUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const StartUpView(),
      );
    case loginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case signUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case homeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const HomeView(),
      );
    case createPostViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreatePostView(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, required Widget viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => viewToShow,
  );
}
