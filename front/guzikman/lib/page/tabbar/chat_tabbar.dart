import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guzikman/controller/chat_controller.dart';
import 'package:guzikman/model/user_model.dart';
import 'package:guzikman/page/widget/chat_card.dart';

class ChatTab extends GetView<ChatController> {
  ChatTab({super.key, required this.nickname});
  String nickname;
  @override
  Widget build(BuildContext context) {
    print(nickname);
    UserModel me = UserModel(nickname: nickname);
    Get.put(ChatController());
    return ListView.builder(
      itemCount: controller.chats.length,
      itemBuilder: (context, index) {
        var current = controller.chats[index];
        return ChatCard(
          chatModel: current,
          me: me,
        );
      },
    );
  }
}
