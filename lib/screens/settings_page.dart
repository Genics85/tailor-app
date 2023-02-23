import 'package:flutter/material.dart';
import '../config/notification_api.dart';
import '../widgets/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              NotificationAPI.showNotification(
                  title: "Genics",
                  body: "A simple notification",
                  payload: "nothing");
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(size.width * 0.32, size.height * 0.057),
                foregroundColor: AppColors.colorDark,
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 18,
                )),
            child: const Text("Simple Notification")),
        ElevatedButton(
            onPressed: () {
              debugPrint("clicked");
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(size.width * 0.32, size.height * 0.057),
                foregroundColor: AppColors.colorDark,
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 18,
                )),
            child: const Text("Scheduled notification")),
        ElevatedButton(
            onPressed: () {
              debugPrint("clicked");
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(size.width * 0.32, size.height * 0.057),
                foregroundColor: AppColors.colorDark,
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 18,
                )),
            child: const Text("Time bound notification")),
      ]),
    ));
  }
}
