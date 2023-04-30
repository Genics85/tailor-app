// import 'dart:math';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';

// class NotificationAPI {
//   static Future<bool> instantNotify() async {
//     final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
//     return awesomeNotifications.createNotification(
//         content: NotificationContent(
//             id: Random().nextInt((100)),
//             title: "Instant Delivery",
//             body: "Notification to notify you that there is nothing",
//             channelKey: "instant_notification"));
//   }

//   static Future<bool> scheduleNotification() async {
//     final awesomeNotification = AwesomeNotifications();
//     return await awesomeNotification.createNotification(
//         content: NotificationContent(
//             category: NotificationCategory.Reminder,
//             wakeUpScreen: true,
//             autoDismissible: false,
//             id: Random().nextInt(1000),
//             channelKey: "scheduled_notification",
//             title: "Scheduled notification",
//             body: "schedule body"),
//         schedule: NotificationCalendar(
//             day: 27, month: 2, year: 2023, hour: 07, minute: 59));
//   }

//   static Future<void> retrieveScheduledNotifications() async {
//     final awesomeNotification = AwesomeNotifications();
//     List<NotificationModel> scheduledNotifications =
//         await awesomeNotification.listScheduledNotifications();
//     print(scheduledNotifications);
//   }
// }
