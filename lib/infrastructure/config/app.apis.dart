import 'dart:core';

class AppApis {
  AppApis._();

  /// Firebase Base Url
  static const String _firebaseBaseUrl = 'https://fcm.googleapis.com/';

  /// Firebase Send Notification
  static const String firebaseSendNotification = '${_firebaseBaseUrl}fcm/send';
}
