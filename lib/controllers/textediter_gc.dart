// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TextEditingController_GetxController extends GetxController{
  TextEditingController textEditingController = TextEditingController();
  bool isTyping = false;

  clearMethod(){
    textEditingController.clear();
    update();
  }

  convertIntoTrue(){
    isTyping = true;
    update();
  }
  convertIntoFalse(){
    isTyping = false;
    update();
  }

}