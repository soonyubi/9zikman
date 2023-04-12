import 'package:get/get.dart';
import 'package:guzikman/model/chat_model.dart';
import 'package:guzikman/model/user_model.dart';

class ChatController extends GetxController {
  RxList<ChatModel> chats = <ChatModel>[
    ChatModel(
        recipient: UserModel(nickname: "yeop"),
        time: DateTime.now(),
        lastMessage: "hey there"),
    ChatModel(
        recipient: UserModel(nickname: "hong"),
        time: DateTime.now(),
        lastMessage: "hey there"),
    ChatModel(
        recipient: UserModel(nickname: "soon"),
        time: DateTime.now(),
        lastMessage: "hey there")
  ].obs;
}
