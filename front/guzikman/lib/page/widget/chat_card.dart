import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guzikman/model/chat_model.dart';
import 'package:guzikman/model/user_model.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  ChatCard({super.key, required this.chatModel, required this.me});
  ChatModel chatModel;
  UserModel me;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/chat', arguments: [chatModel, me]);
      },
      onLongPress: () {
        Get.dialog(AlertDialog(
          // title: Text("경고"),
          content: Text("삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                // TODO::삭제 로직 구현
                Get.back();
              },
              child: Text("삭제"),
            ),
          ],
        ));
      },
      child: Column(
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(),
            title: Text(chatModel.recipient.nickname!),
            subtitle: Text(
              "some text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some textsome text some text",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            trailing: Text(DateFormat.yMMMMd().format(chatModel.time)),
          ),
        ],
      ),
    );
  }
}
