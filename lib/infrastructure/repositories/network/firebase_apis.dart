import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final FCMToken = await _firebaseMessaging.getToken();

    debugPrint('FBToken: $FCMToken');

    // await initPushNotifications();
  }

  void handleMessage(final RemoteMessage? message) {
    debugPrint(message.toString());
    debugPrint(message?.notification.toString());
    debugPrint(message?.notification?.title.toString());
    debugPrint(message?.notification?.body.toString());
  }

  Future<void> initPushNotifications() async {
    // await FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessage.listen(handleMessage);
  }
}
