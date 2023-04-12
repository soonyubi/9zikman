import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guzikman/model/message_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageController extends GetxController {
  MessageController({required this.myNickname, required this.targetNickname});
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  //RxList<MessageModel> messages = <MessageModel>[
  //   MessageModel(
  //       nickname: "soon",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(days: 3)),
  //       isSentByMe: true),
  //   MessageModel(
  //       nickname: "soon",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 2)),
  //       isSentByMe: true),
  //   MessageModel(
  //       nickname: "yeop",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 3)),
  //       isSentByMe: false),
  //   MessageModel(
  //       nickname: "soon",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 4)),
  //       isSentByMe: true),
  //   MessageModel(
  //       nickname: "yeop",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 5)),
  //       isSentByMe: false),
  //   MessageModel(
  //       nickname: "yeop",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 6)),
  //       isSentByMe: false),
  //   MessageModel(
  //       nickname: "soon",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 7)),
  //       isSentByMe: true),
  //   MessageModel(
  //       nickname: "soon",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 8)),
  //       isSentByMe: true),
  //   MessageModel(
  //       nickname: "yeop",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 9)),
  //       isSentByMe: false),
  //   MessageModel(
  //       nickname: "soon",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 10)),
  //       isSentByMe: true),
  //   MessageModel(
  //       nickname: "yeop",
  //       text: "some text",
  //       date: DateTime.now().subtract(Duration(minutes: 11)),
  //       isSentByMe: false),
  // ].obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;
  RxBool isEmojiVisible = false.obs;
  RxBool isShowModal = false.obs;
  RxBool isReadyToSend = false.obs;
  TextEditingController textEditingController = TextEditingController();
  late final WebSocketChannel? channel;

  String? targetNickname;
  String? myNickname;
  @override
  void onInit() async {
    super.onInit();

    channel = IOWebSocketChannel.connect(Uri.parse(
        "wss://995blb3iw1.execute-api.us-east-1.amazonaws.com/dev?nickname=${myNickname!}"));
    channel!.sink.add(jsonEncode({
      "action": "getMessages",
      "targetNickname": targetNickname,
      "limit": 1000
    }));
    channel!.stream.listen((event) {
      var jsonEvent = json.decode(event);
      // print(jsonEvent);

      if (jsonEvent['type'] == 'messages') {
        final past_messages = jsonEvent['value']['messages'].toList();
        past_messages.map((m) => print(m));
      } else if (jsonEvent['type'] == 'message') {
        print("add Message");
        MessageModel newMessage = MessageModel(
            nickname: jsonEvent['value']['sender'],
            text: jsonEvent['value']['message'],
            date: DateTime.now(),
            isSentByMe: (jsonEvent['value']['sender'] == myNickname));

        messages.add(newMessage);
      }
    });
  }

  @override
  void dispose() {
    channel!.sink.close();
    textEditingController.dispose();
    super.dispose();
  }

  void setMyNickname(String myNickname) {
    this.myNickname = myNickname;
  }

  void setTargetNickname(String targetNickname) {
    this.targetNickname = targetNickname;
  }

  void connect2() {
    // channel = IOWebSocketChannel.connect(Uri.parse(
    //     "wss://995blb3iw1.execute-api.us-east-1.amazonaws.com/dev?nickname=soon"));
  }

  showModalClicked() {
    if (isShowModal.isTrue)
      isShowModal = false.obs;
    else
      isShowModal = true.obs;
  }

  emojiVisibleClicked() {
    if (isEmojiVisible.isTrue)
      isEmojiVisible = false.obs;
    else
      isEmojiVisible = true.obs;
  }

  readyToSendClicked() {
    if (isReadyToSend.isTrue)
      isReadyToSend = false.obs;
    else
      isReadyToSend = true.obs;
  }

  void addMessage(MessageModel newMessage) {
    channel!.sink.add(jsonEncode({
      "action": "sendMessage",
      "message": newMessage.text,
      "recipientNickname": targetNickname
    }));

    messages.add(newMessage);
  }

  void closeConnection() {
    channel!.sink.close();
  }
}
