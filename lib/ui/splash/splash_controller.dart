import 'dart:io';

import 'package:base_pm2/commons/networks/network_utils.dart';
import 'package:base_pm2/commons/resource/export_resource.dart';
import 'package:base_pm2/commons/utils/base_view/base_controller.dart';
import 'package:base_pm2/commons/utils/local_service/shared_pref.dart';
import 'package:base_pm2/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SplashController extends BaseController {

  @override
  initialData()async {
    bool checkNetwork = await NetworkUtils.hasConnection();
    if (checkNetwork) {
      if (Platform.isAndroid || Platform.isIOS) {
        await initFirebaseMessage();
      }
    } else {}
  }

  late FirebaseMessaging fm;

  initFirebaseMessage() async {
    fm = FirebaseMessaging.instance;
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("message Data: ${message.data}");
      }
    });

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id, channel.name, channel.description,
                  //      one that already exists in example app.
                  icon: 'launch_background',
                  importance: Importance.max),
            ));
      }

      print("Recevei notification");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Application opened from Notification');
      var key = message.data.keys.first;
      print('Key $key');
      print('Value ${message.data[key]}');
      print("${message.notification!.title}");
      print("${message.data["event"]}");
      //kiểm tra message có dữ liệu tên event ko
      //lắng nghe và mở đến page thông báo
    });

    NotificationSettings settings = await fm.requestPermission(
      alert: true,
      announcement: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    }

    fm.getToken().then((String? token) {
      if (token != null) {
        SharedPref.putString(KeyResource.fcmKey, token);
        KeyResource.fcm = token;
        // print("Push Messaging token: $token");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        print(
            'Message also contained a notification: ${message.notification!.title}');
        print(
            'Message also contained a notification: ${message.notification!.body}');
        // MessageNotify messageNotify = MessageNotify(
        //     title: message.notification!.title,
        //     titleLocArgs: message.notification!.titleLocArgs,
        //     titleLocKey: message.notification!.titleLocKey,
        //     body: message.notification!.body,
        //     bodyLocArgs: message.notification!.bodyLocArgs,
        //     bodyLocKey: message.notification!.bodyLocKey);
      }
    });
  }


}
