import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../Data/Repositories/Notification/notification_repository.dart';

class NotificationConfig {
  void messagingInitiation() async {
    // String? fcmToken = await FirebaseMessaging.instance.getToken();
    await FirebaseMessaging.instance.getNotificationSettings();

    // log('FCM Token:$fcmToken');
    FirebaseMessaging.onMessage.listen((e) async {
      // log("checking logs for messages on message ${e.messageId}  ${e.category}  ${e.from}  ${e.messageType}   ${e.contentAvailable}  data  ${e.data.entries}  title: ${e.ttl}");
      log(e.toMap().toString());
      NotificationRepository()
          .showNotification(1, e.notification!.title!, e.notification!.body!);
    }).onError((error) {
      log("checking logs   $error");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((e) async {
      log("checking logs for messages onMessageOpened ");
      NotificationRepository()
          .showNotification(1, e.notification!.title!, e.notification!.body!);
    });

    FirebaseMessaging.onBackgroundMessage((e) async {
      log(" checking logs for background message ");
      NotificationRepository()
          .showNotification(1, e.notification!.title!, e.notification!.body!);
      // return handleBackend();
    });
  }

  notificationPayload(
    BuildContext context,
  ) {
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => const Dashboard(title: 'Dashboard')),
    //       (route) => false);
  }
}
