import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guzikman/page/chat_page.dart';
import 'package:guzikman/page/home_page.dart';
import 'package:guzikman/page/login_page.dart';
import 'package:guzikman/page/register_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '9zikman',
      theme: FlexThemeData.light(
        scheme: FlexScheme.bigStone,
        textTheme: Typography.blackCupertino,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: "/register", page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: "/chat", page: () => ChatPage())
      ],
    );
  }
}
