import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:guzikman/controller/home_controller.dart';
import 'package:guzikman/page/tabbar/chat_tabbar.dart';
import 'package:guzikman/page/tabbar/home_tabbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final _tabBarController;
  final controller = Get.put(HomeController());
  bool _isLight = true;
  final nickname = Get.parameters['nickname'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabBarController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    print(nickname);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.accessibility_new_rounded),
        title: Text("구직맨"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.changeTheme(_isLight);
                setState(() {
                  _isLight = !_isLight;
                });
              },
              icon: _isLight
                  ? Icon(Icons.light_mode_rounded)
                  : Icon(Icons.dark_mode_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
        ],
        leadingWidth: 60,
        bottomOpacity: 0.8,
        bottom: TabBar(
          controller: _tabBarController,
          tabs: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Home")),
            Text("Chat"),
            Text("Follow"),
            CircleAvatar(radius: 13)
          ],
        ),
      ),
      body: TabBarView(controller: _tabBarController, children: [
        HomeTab(),
        ChatTab(nickname: nickname!),
        Text("nofify"),
        Text("profile"),
      ]),
    );
  }
}
