import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guzikman/controller/message_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: _textEditingController,
          ),
          TextButton(
              onPressed: () {
                Get.offNamed("/home?nickname=${_textEditingController.text}");
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
