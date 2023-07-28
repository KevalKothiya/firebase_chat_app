// ignore_for_file: camel_case_types

import 'package:firebase_chat_app/modals/global/welcome_page_model.dart';
import 'package:firebase_chat_app/modals/util/utils.dart';
import 'package:get/get.dart';

class Welcome_GetxController extends GetxController {
  WelconeModel welconeModel =
      WelconeModel(index: 0, welcomeOver: box.read('welcomeOver') ?? false);

  initializedTrueForWelcome({required bool val}) {
    welconeModel.welcomeOver = val;
    box.write('welcomeOver', welconeModel.welcomeOver);
    update();
  }

  initializedValue({required int index}) {
    welconeModel.index = index;
    update();
  }
}
