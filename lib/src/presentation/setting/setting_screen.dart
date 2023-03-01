import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/setting_provider.dart';
import '../shared_widgets/custom_dialog.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Consumer<SettingProvider>(
        builder: (context, state, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListTile(
              title: const Text("Notification"),
              trailing: Switch.adaptive(
                value: state.isScheduled,
                onChanged: (value) async {
                  if (Platform.isIOS) {
                    customDialog(context);
                  } else {
                    state.scheduledRestaurant(value);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
