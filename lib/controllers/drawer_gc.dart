// ignore_for_file: camel_case_types

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class Drawer_GetxController extends GetxController{
  final zoomDrawerController = ZoomDrawerController();

  void Drawer() {
    zoomDrawerController.toggle?.call();
    update();
  }
}