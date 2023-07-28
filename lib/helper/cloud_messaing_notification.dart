import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class CMFBHelper {
  //CMFBH = Cloud Messaging Firebase Helper
  CMFBHelper._();

  static final CMFBHelper cmfbHelper = CMFBHelper._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  sendCMbyApi({required Map<String, dynamic> user, required String msg}) async {
    try {
      String api = "https://fcm.googleapis.com/fcm/send";
      Map<String, String> myHeaders = {
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAADtfcg7Q:APA91bHCgzIEg6UusvHWqdq--jbHf8aEvRNzhXkWpfRcswtUAWwen9UN79RiOhejOy58qE0knUHWxtIvum_xX2dh05uTyJIGhn9VTd3mH10lh_jodwrltDuVAdU0LhU-5-OdtctbcvU-"
      };

      Map<String, dynamic> myBody = {
        "to": user['push_token'],
        "notification": {
          "title": "ChatApp-${user['name']}",
          "body": msg,
          "mutable_content": true,
          "sound": "Tri-tone"
        },
        "data": {
          "name": "Rahul",
          "age": "22",
          "clg": "PQR",
        }
      };

      await http.post(
        Uri.parse(api),
        headers: myHeaders,
        body: jsonEncode(myBody),
      );
    } catch (e) {
      log("Api Error :$e");
    }
  }
}
