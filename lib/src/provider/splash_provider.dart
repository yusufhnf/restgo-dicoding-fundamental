import 'package:flutter/material.dart';

import '../presentation/home/home_screen.dart';

class SplashProvider extends ChangeNotifier {
  final int _splashDuration = 3;
  final BuildContext context;

  SplashProvider(this.context) {
    _initial();
  }

  void _initial() {
    Future.delayed(Duration(seconds: _splashDuration), () {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ));
    });
  }
}
