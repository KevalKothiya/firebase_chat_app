import 'package:firebase_chat_app/modals/global/drawer_menu.dart';
import 'package:firebase_chat_app/modals/util/utils.dart';
import 'package:firebase_chat_app/pages/main_screen.dart';
import 'package:firebase_chat_app/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuItem currentItem = MenuItems.profile;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 40,
      showShadow: true,
      style: DrawerStyle.defaultStyle,
      mainScreen: MainScreen(),
      menuScreen: Builder(
        builder: (context) {
          return MenuScreen(
            currentItem : currentItem,
            onSelectedItem : (item){
              setState(() {
                currentItem = item;
                ZoomDrawer.of(context)!.close();
                // Get.back();
                // Get.toNamed('/profile_page');
              });
            },
          );
        }
      ),
    );
  }
}
