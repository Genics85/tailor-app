import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationAPI {
  static Future<bool> instantNotify() async {
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();

    return awesomeNotifications.createNotification(
        content: NotificationContent(
            id: Random().nextInt((100)),
            title: "Instant Delivery",
            body: "Notification to notify you that there is nothing",
            channelKey: "instant_notification"));
  }
}
