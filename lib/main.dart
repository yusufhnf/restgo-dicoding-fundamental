import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restgo/src/helper/background_service_helper.dart';
import 'package:restgo/src/presentation/detail/detail_screen.dart';
import 'package:restgo/src/presentation/favourites/favorites_screen.dart';
import 'package:restgo/src/presentation/home/home_screen.dart';
import 'package:restgo/src/presentation/search/search_screen.dart';
import 'package:restgo/src/presentation/setting/setting_screen.dart';
import 'package:restgo/src/presentation/splash/splash_screen.dart';
import 'package:restgo/src/provider/setting_provider.dart';

import 'src/helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundServiceHelper service = BackgroundServiceHelper();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestGo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        FavoritesScreen.routeName: (context) => const FavoritesScreen(),
        SettingScreen.routeName: (context) =>
            ChangeNotifierProvider<SettingProvider>(
              create: (context) => SettingProvider(),
              child: const SettingScreen(),
            ),
        SearchScreen.routeName: (context) => const SearchScreen(),
        DetailScreen.routeName: (context) => DetailScreen(
            restaurantData:
                ModalRoute.of(context)?.settings.arguments as String)
      },
      home: const SplashScreen(),
    );
  }
}
