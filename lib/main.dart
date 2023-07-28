import 'dart:developer';
import 'package:firebase_chat_app/pages/settings/chat_sp.dart';
import 'package:firebase_chat_app/screens/welcome_page.dart';
import 'package:firebase_chat_app/screens/chat_page.dart';
import 'package:firebase_chat_app/screens/home_page.dart';
import 'package:firebase_chat_app/screens/login_page.dart';
import 'package:firebase_chat_app/screens/profile_page.dart';
import 'package:firebase_chat_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:get_storage/get_storage.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackGroungHandle(RemoteMessage message) async {
  log("=====BACKGROUND=======");
}
void main() async {

  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log("=====FORGROUND=======");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackGroungHandle);
  runApp(
    Sizer(
      builder: (context, _, __) {
        return GetMaterialApp(
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          initialRoute:'/splash_screen',
          getPages: [
            GetPage(name: '/', page: () => const HomePage()),
            GetPage(name: '/splash_screen', page: () => const SplashScreen()),
            GetPage(name: '/login_page', page: () => const LoginPage()),
            GetPage(name: '/profile_page', page: () => const ProfilePage()),
            GetPage(name: '/chat_page', page: () => const ChatPage()),
            GetPage(name: '/welcome_page', page: () => const WelcomePage()),
            GetPage(name: '/setting_chat_page', page: () => const SettingChats()),
          ],
        );
      },
    ),
  );
}