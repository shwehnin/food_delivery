import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iosInitialize = const DarwinInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    flutterLocalNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      try {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            StreamController<String?>.broadcast()
                .add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == 'id_3') {
              StreamController<String?>.broadcast()
                  .add(notificationResponse.payload);
              break;
            }
        }
      } catch (e) {
        if (kDebugMode) {
          print("Notification Error $e");
        }
      }
      return;
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("****************onMessage****************");
      print(
          "onMessage: ${message.notification?.title}/ ${message.notification?.body}/ ${message.notification?.titleLocKey}");
      NotificationHelper.showNotification(
        message,
        flutterLocalNotificationPlugin,
      );
      if (Get.find<AuthController>().userLoggedIn()) {}
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "onOpenApp: ${message.notification?.title}/ ${message.notification?.body}/ ${message.notification?.titleLocKey}");
      try {
        if (message.notification?.titleLocKey != null &&
            message.notification?.titleLocKey != null) {
          // Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(message.notification!.titleLocKey!)))
        } else {
          // Get.toNamed(RouteHelper.getNotificationRoute());
        }
      } catch (e) {
        print("On Open Notification Error $e");
      }
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body!,
      htmlFormatBigText: true,
      contentTitle: message.notification?.title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpicifics =
        AndroidNotificationDetails(
      'channel_id_1',
      'dbfood',
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpicifics,
      iOS: const DarwinNotificationDetails(),
    );
    await flutterLocalNotificationPlugin.show(0, message.notification?.title,
        message.notification?.body, platformChannelSpecifics);
  }
}
