import 'package:firebase_chat_app/controllers/log_in_out_gc.dart';
import 'package:firebase_chat_app/helper/cloud_firestore_helper.dart';
import 'package:firebase_chat_app/helper/firebase_auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Google_login_out_GetController google_login_out_getController =
      Get.put(Google_login_out_GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
            onPressed: () async {
              Map<String, dynamic> data =
                  await FBHelper.fbHelper.singInWithGoogle();

              if (data['user'] != null) {
                Get.snackbar(
                  "Success",
                  "Sing in Successfull...",
                  backgroundColor: Colors.green,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 1),
                );
                debugPrint("ok");
                if (await CFSHelper.cfsHelper.userExits()) {
                  debugPrint("1");
                  print("100");
                  CFSHelper.cfsHelper.diplayAllRecode();
                  Get.offAndToNamed('/');

                  debugPrint("2");
                } else {
                  debugPrint("3");
                  CFSHelper.cfsHelper
                      .createUser()
                      .then((value) => Get.offAndToNamed('/'));
                  debugPrint("4");
                }
                debugPrint("5");
                google_login_out_getController.trueValue();
                debugPrint("6");
              } else {
                Get.snackbar(
                  "Failed",
                  data['msg'],
                  backgroundColor: Colors.redAccent,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 1),
                );
              }
            },
            child: Text("Google")),
      ),
    );
  }
}
