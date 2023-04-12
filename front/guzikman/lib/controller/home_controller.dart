import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  bool _isLightMode = false;
  bool get isLightMode => _isLightMode;

  changeTheme(currentState) {
    if (!currentState) {
      Get.changeTheme(FlexThemeData.light(
        scheme: FlexScheme.bigStone,
        textTheme: Typography.blackCupertino,
      ));
    } else {
      Get.changeTheme(FlexThemeData.dark(
          scheme: FlexScheme.amber, textTheme: Typography.whiteCupertino));
    }
  }
}
