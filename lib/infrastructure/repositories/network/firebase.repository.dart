import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../config/app.apis.dart';
import 'i.interface.repository.dart';

class FirebaseRepository extends NetworkRepository {
  final String _messageKey = 'AAAAJuAIYrY:'
      'APA91bHVGsXnQSACai0XH4R3bub6qH1qS4MumY5oqU5pOC_izKn9lrEZ6FRNT_BSaOQQvvz_q'
      '-'
      'hmnKpkoNa0fcRFEJdpXYWXkJOC500Y5y075dH35voqRuN5p8xFq1GU4unx4vy9r5GK';

  Future<Either<DioException, Response<dynamic>>> requestAndroidNotification(
      final String request) async {
    final response = await post(
      AppApis.firebaseSendNotification,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=$_messageKey',
      },
      body: request,
    );

    return response;
  }

  Future<Either<Exception, String>> getFcmToken() async {
    final String? fcmToken;
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
    } on Exception catch (e) {
      return left(e);
    }

    return right(fcmToken!);
  }
}
