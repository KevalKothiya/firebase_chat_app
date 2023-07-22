import 'package:firebase_chat_app/screens/welcome_page.dart';
import 'package:firebase_chat_app/screens/chat_page.dart';
import 'package:firebase_chat_app/screens/home_page.dart';
import 'package:firebase_chat_app/screens/login_page.dart';
import 'package:firebase_chat_app/screens/profile_page.dart';
import 'package:firebase_chat_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:get_storage/get_storage.dart';

void main() async {

  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    Sizer(
      builder: (context, _, __) {
        return GetMaterialApp(
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          initialRoute:'/splash_screen',
          getPages: [
            GetPage(name: '/', page: () => HomePage()),
            GetPage(name: '/splash_screen', page: () => SplashScreen()),
            GetPage(name: '/login_page', page: () => LoginPage()),
            GetPage(name: '/profile_page', page: () => ProfilePage()),
            GetPage(name: '/chat_page', page: () => ChatPage()),
            GetPage(name: '/welcome_page', page: () => WelcomePage()),
          ],
        );
      },
    ),
  );
}