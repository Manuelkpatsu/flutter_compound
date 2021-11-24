import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercompoundapp/ui/router.dart';

import 'core/services/dialog_service.dart';
import 'core/services/navigation_service.dart';
import 'locator.dart';
import 'managers/dialog_manager.dart';
import 'ui/views/startup_view.dart';

Future<void> main() async {
  // Register all the models and services before the app starts
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Compound',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: child!),
        ),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 9, 202, 172),
        backgroundColor: const Color.fromARGB(255, 26, 27, 30),
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      ),
      home: const StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}
