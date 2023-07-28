import 'package:firebase_chat_app/controllers/Welcome_page_gc.dart';
import 'package:firebase_chat_app/controllers/log_in_out_gc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver{
  Google_login_out_GetController google_login_out_getController =
      Get.put(Google_login_out_GetController());
  Welcome_GetxController welcomeController = Get.put(Welcome_GetxController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2))
        .then((value) => (welcomeController.welconeModel.welcomeOver)
            ? (google_login_out_getController.google_login_out_modal.isLogin)
                ? Get.offAndToNamed('/')
                : Get.offAndToNamed('/login_page')
            : Get.offAllNamed('/welcome_page'));
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
      ),
    );
  }
}
