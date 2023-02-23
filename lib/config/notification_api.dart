import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationAPI {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<NotificationDetails?> _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            "channel id", "channel name", "channel description",
            importance: Importance.max),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings("@mipmap/ic_launcher");
    final IOS = IOSInitializationSettings();

    final settings = InitializationSettings(android: android, iOS: IOS);
    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {});
  }

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
