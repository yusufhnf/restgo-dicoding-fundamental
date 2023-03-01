import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade900,
      body: ChangeNotifierProvider<SplashProvider>(
          create: (context) => SplashProvider(context),
          child: Consumer<SplashProvider>(builder: (context, state, _) {
            return Center(
              child: Text(
                "RestGo",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: Colors.white),
              ),
            );
          })),
    );
  }
}
