import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static const String routeName = 'HomeView';

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home'),
    );
  }
}
