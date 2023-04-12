import 'package:guzikman/model/user_model.dart';

class ChatModel {
  UserModel recipient;
  DateTime time;
  String lastMessage;

  ChatModel(
      {required this.recipient, required this.time, required this.lastMessage});
}
