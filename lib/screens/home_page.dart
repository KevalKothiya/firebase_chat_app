import 'package:firebase_chat_app/controllers/dark_theme_gc.dart';
import 'package:firebase_chat_app/modals/global/drawer_menu.dart';
import 'package:firebase_chat_app/modals/util/utils.dart';
import 'package:firebase_chat_app/pages/main_screen.dart';
import 'package:firebase_chat_app/pages/menu_page.dart';
import 'package:firebase_chat_app/pages/settings/chat_sp_from_menu_widget.dart';
import 'package:firebase_chat_app/screens/profile_page.dart';
import 'package:firebase_chat_app/screens/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuItem currentItem = MenuItems.home;
  DarkMode_GetxController darkController = Get.put(DarkMode_GetxController());

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
        return MainScreen();
      case MenuItems.setting:
        return SettingPage();
      case MenuItems.chat:
        return SettingChatsFromMenuWidget();
      case MenuItems.profile:
        return ProfilePage();
      default:
        return HomePage();
    }
  }
}
