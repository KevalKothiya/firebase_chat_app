import 'package:firebase_chat_app/modals/global/dark_theme.dart';
import 'package:firebase_chat_app/modals/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkMode_GetxController extends GetxController {
  DarkModeModel darkModeModel = DarkModeModel(
    isDarkMode: box.read('isDarkMode') ?? false,
  );

  darkThemeUDF({required bool val}) {
    darkModeModel.isDarkMode = val;
    box.write('isDarkMode', darkModeModel.isDarkMode);
    (darkModeModel.isDarkMode)
        ? Get.changeTheme(
      ThemeData.dark(
        useMaterial3: true,
      ),
    )
        : Get.changeTheme(
      ThemeData.light(useMaterial3: true),
    );
    update();
  }
}
