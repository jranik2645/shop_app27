import 'dart:io';
import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shop_app27/screens/user_panel/main_screen.dart';
import 'package:shop_app27/screens/user_panel/notification_screen.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///for  notification request
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user provisional granted permission");
    } else {
      Get.snackbar(
        "Notification permission denied",
        "Please allow notification to receive updates",
        snackPosition: SnackPosition.BOTTOM,
      );
      Future.delayed(Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  ///get token///

  Future<String> getDeviceToken() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    String? token = await messaging.getToken();
    if (kDebugMode) {
      print("token=>$token");
    }
    return token!;
  }

  ///init

  void initLocalNotification(
    BuildContext context,
    RemoteMessage message,
  ) async {
    var androidInitSetting = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    var iosInitSetting = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitSetting,
      iOS: iosInitSetting,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  ///firebase init

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notification title:${notification!.title}");
        print("notification body:${notification.body}");
      }

      ///ios
      if (Platform.isIOS) {
        iosForgroundMessage();
      }

      ///android///

      if (Platform.isAndroid) {
        initLocalNotification(context, message);
       // handleMessage(context, message);
        showNotification(message);
      }
    });
  }

  ///function notification

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.high,
      showBadge: true,
      playSound: true,
    );
     AndroidNotificationDetails androidNotificationDetails=
         AndroidNotificationDetails(
             channel.id.toString(),
           channel.name.toString(),
           channelDescription: "Channel Description",
           importance: Importance.high,
           priority: Priority.high,
           playSound: true,
           sound: channel.sound,

         );

        //IOS SETTING .//

     DarwinNotificationDetails darwinNotificationDetails=
          DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true
          );

      NotificationDetails notificationDetails=
          NotificationDetails(
            android: androidNotificationDetails,
            iOS: darwinNotificationDetails,
          );

        ///show notification

       Future.delayed(
         Duration.zero,
           (){
           flutterLocalNotificationsPlugin.show(
              0,
               message.notification!.title.toString(),
               message.notification!.body.toString(),
               notificationDetails,
                payload: 'my_data',

           );
           }
       );

  }

  ///background and terminated

  Future<void> setupInteractMessage(BuildContext context) async {
    ///background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });

    ///terminated state
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null && message.data.isNotEmpty) {
        handleMessage(context, message!);
      }
    });
  }

  ///handle message

  Future<void> handleMessage(
    BuildContext context,
    RemoteMessage message,
  ) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationScreen()),
    );
  }

  ///ios message
  Future iosForgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }


}
