import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMHelper {
  FCMHelper._();

  static final FCMHelper fcmHelper = FCMHelper._();

  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> fetchTokan() async {
    await firebaseMessaging.requestPermission();
    String? token = await  firebaseMessaging.getToken();
    log(token.toString());
    return await firebaseMessaging.getToken();
  }
}