class Message {
  Message({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });

  late String toId;
  late String msg;
  late String read;
  late String fromId;
  late String sent;
  late Type type;

  Message.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json['fromId'].toString();
    sent = json['sent'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    return data;
  }
}

enum Type {text, image}

// class MessageModel {
//   String msg;
//   String read;
//   String fromId;
//   String toId;
//   Type type;
//   String send;
//
//   MessageModel({
//     required this.msg,
//     required this.read,
//     required this.fromId,
//     required this.toId,
//     required this.type,
//     required this.send,
//   });
//
//   factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
//     msg: json["msg"],
//     read: json["read"],
//     fromId: json["from_id"],
//     toId: json["to_id"],
//     type: json["type"] == Type.image.name ? Types.image : Types.text,
//     send: json["send"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "msg": msg,
//     "read": read,
//     "from_id": fromId,
//     "to_id": toId,
//     "type": type,
//     "send": send,
//   };
// }