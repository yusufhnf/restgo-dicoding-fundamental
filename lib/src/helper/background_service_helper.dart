import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';

import '../data/model/restaurant_model.dart';
import '../data/remote/restaurant_remote_datasource.dart';
import '../../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundServiceHelper {
  static BackgroundServiceHelper? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundServiceHelper._internal() {
    _instance = this;
  }

  factory BackgroundServiceHelper() =>
      _instance ?? BackgroundServiceHelper._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    RestaurantModel result =
        await RestaurantRemoteDataSource().getRandomRestaurant();
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    debugPrint('Execute some process');
  }
}
