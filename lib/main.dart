import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:tailor/widgets/colors.dart';
import 'screens/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: "instant_notification",
        channelName: "Basic notification",
        channelDescription: "Notification channel for tutorial",
        defaultColor: AppColors.colorDark,
        ledColor: AppColors.colorLight,
        
        ),
    NotificationChannel(
        channelKey: "scheduled_notification",
        channelName: "scheduled notification",
        channelDescription: "This is for testing scheduled notificatioin",
        defaultColor: AppColors.colorDark,
        ledColor: AppColors.colorLight),
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(),
    );
  }
}
