import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:guzikman/controller/message_controller.dart';
import 'package:guzikman/model/chat_model.dart';
import 'package:guzikman/model/user_model.dart';
import 'package:guzikman/model/message_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  FocusNode _focusNode = FocusNode();

  ChatModel chat = Get.arguments[0];
  UserModel me = Get.arguments[1];
  @override
  Widget build(BuildContext context) {
    MessageController controller = Get.put(MessageController(
        myNickname: me.nickname, targetNickname: chat.recipient.nickname));

    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            controller.closeConnection();
            Get.back();
          },
        ),
        title: Text(chat.recipient.nickname!),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(child: Text("신고하기"), value: "신고하기"),
                  PopupMenuItem(child: Text("팔로우"), value: "팔로우"),
                ];
              }),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => SizedBox(
          height: Get.height,
          width: Get.width,
          // color: Colors.red,
          child: GestureDetector(
            onTap: () {
              controller.isEmojiVisible = false.obs;
              controller.isShowModal = false.obs;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.8,
                    child: GroupedListView(
                      reverse: true,
                      order: GroupedListOrder.DESC,
                      useStickyGroupSeparators: false,
                      floatingHeader: true,
                      elements: controller.messages.toList(),
                      groupBy: (message) => DateTime(message.date!.year,
                          message.date!.month, message.date!.day),
                      groupHeaderBuilder: (MessageModel message) => SizedBox(
                        height: 30,
                        child: Center(
                          child: Card(
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                DateFormat.yMMMd().format(message.date!),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      itemBuilder: (context, MessageModel message) => Align(
                        alignment: message.isSentByMe!
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(message.text!),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width,
                            child: Card(
                              margin:
                                  EdgeInsets.only(left: 2, right: 2, bottom: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextFormField(
                                onTapOutside: (_) {
                                  _focusNode.unfocus();
                                },
                                onChanged: (value) {
                                  if (value.length > 0) {
                                    controller.isReadyToSend = true.obs;
                                  } else {
                                    controller.isReadyToSend = false.obs;
                                  }
                                },
                                onTap: () {
                                  controller.isEmojiVisible = false.obs;
                                },
                                focusNode: _focusNode,
                                controller: controller.textEditingController,
                                maxLines: 5,
                                minLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(5),
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        controller.showModalClicked();
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (builder) =>
                                                bottomSheet());
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        size: 30,
                                      ),
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              controller.emojiVisibleClicked();
                                              _focusNode.unfocus();
                                              _focusNode.canRequestFocus =
                                                  false;
                                              //TODO : emoji 버튼을 누르면 업데이트가 바로 반영이 안됨
                                              // TODO : 값은 변경되는데, 어떻게 바로 업데이트를 시킬수 있을지 고민해봐야됌

                                              print(controller.isEmojiVisible);
                                            },
                                            icon: Icon(
                                                Icons.emoji_emotions_rounded)),
                                        CircleAvatar(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          child: IconButton(
                                              onPressed: () {
                                                _focusNode.unfocus();
                                                MessageModel newMessage =
                                                    MessageModel(
                                                        nickname: me.nickname,
                                                        text: controller
                                                            .textEditingController
                                                            .text,
                                                        date: DateTime.now(),
                                                        isSentByMe: true);
                                                controller
                                                    .addMessage(newMessage);
                                                controller.textEditingController
                                                    .clear();
                                                controller.isReadyToSend =
                                                    false.obs;
                                              },
                                              icon: Icon(
                                                  Icons.arrow_upward_rounded)),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // EmojiSelect()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: Get.height * 0.35,
      width: Get.width,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                iconCreation(Icons.insert_drive_file, Colors.blue, "Document"),
                iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                iconCreation(Icons.insert_photo, Colors.purple, "Gallery")
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                iconCreation(Icons.headphones, Colors.orange, "Audio"),
                iconCreation(Icons.location_pin, Colors.pink, "Location"),
                iconCreation(Icons.person, Colors.blue, "Contact")
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(icon, size: 29, color: color),
          ),
          Text(text)
        ],
      ),
    );
  }

  // Widget EmojiSelect() {
  //   return Offstage(
  //     offstage: controller.isEmojiVisible.isTrue,
  //     child: SizedBox(
  //       height: 250,
  //       child: EmojiPicker(
  //         textEditingController: controller.textEditingController,
  //         config: Config(
  //           columns: 7,
  //           // Issue: https://github.com/flutter/flutter/issues/28894
  //           emojiSizeMax: 32 *
  //               (foundation.defaultTargetPlatform == TargetPlatform.iOS
  //                   ? 1.30
  //                   : 1.0),
  //           verticalSpacing: 0,
  //           horizontalSpacing: 0,
  //           gridPadding: EdgeInsets.zero,
  //           initCategory: Category.RECENT,
  //           bgColor: const Color(0xFFF2F2F2),
  //           indicatorColor: Colors.blue,
  //           iconColor: Colors.grey,
  //           iconColorSelected: Colors.blue,
  //           backspaceColor: Colors.blue,
  //           skinToneDialogBgColor: Colors.white,
  //           skinToneIndicatorColor: Colors.grey,
  //           enableSkinTones: true,
  //           showRecentsTab: true,
  //           recentsLimit: 28,
  //           replaceEmojiOnLimitExceed: false,
  //           noRecents: const Text(
  //             'No Recents',
  //             style: TextStyle(fontSize: 20, color: Colors.black26),
  //             textAlign: TextAlign.center,
  //           ),
  //           loadingIndicator: const SizedBox.shrink(),
  //           tabIndicatorAnimDuration: kTabScrollDuration,
  //           categoryIcons: const CategoryIcons(),
  //           buttonMode: ButtonMode.MATERIAL,
  //           checkPlatformCompatibility: true,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
