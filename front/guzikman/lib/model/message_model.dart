class MessageModel {
  String? nickname;
  String? text;
  DateTime? date;
  bool? isSentByMe;

  MessageModel(
      {required this.nickname,
      required this.text,
      required this.date,
      required this.isSentByMe});
}
