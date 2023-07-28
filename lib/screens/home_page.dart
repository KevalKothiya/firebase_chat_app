// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';
import 'package:firebase_chat_app/controllers/dark_theme_gc.dart';
import 'package:firebase_chat_app/helper/cloud_messaing_notification.dart';
import 'package:firebase_chat_app/modals/global/drawer_menu.dart';
import 'package:firebase_chat_app/modals/util/utils.dart';
import 'package:firebase_chat_app/pages/main_screen.dart';
import 'package:firebase_chat_app/pages/menu_page.dart';
import 'package:firebase_chat_app/pages/settings/chat_sp_from_menu_widget.dart';
import 'package:firebase_chat_app/screens/profile_page.dart';
import 'package:firebase_chat_app/screens/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  MenuItem currentItem = MenuItems.home;
  DarkMode_GetxController darkController = Get.put(DarkMode_GetxController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    var androidInitializationSettings =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    var darwinInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);
    tz.initializeTimeZones();
    CMFBHelper.flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log("+++++++++++++++++++");
        log("PLAYLOAD: ${response.payload}");
        log("+++++++++++++++++++");
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        log('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        log('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        log('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        log('appLifeCycleState detached');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage((darkController.darkModeModel.isDarkMode)
                ? "assets/images/drawer_wallpaper.jpg"
                : "assets/images/light_drawer_wallpaper.jpg"),
            fit: BoxFit.cover),
      ),
      child: ZoomDrawer(
        // menuBackgroundColor: Colors.indigo,
        borderRadius: 40,
        showShadow: true,
        style: DrawerStyle.defaultStyle,
        mainScreen: getScreen(),
        menuScreen: Builder(builder: (context) {
          return MenuScreen(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() {
                currentItem = item;
                ZoomDrawer.of(context)!.close();
              });
            },
          );
        }),
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return const MainScreen();
      case MenuItems.setting:
        return const SettingPage();
      case MenuItems.chat:
        return const SettingChatsFromMenuWidget();
      case MenuItems.profile:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}
