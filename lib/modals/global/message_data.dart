class Message {
  Message({
    required this.toId,
    required this.id,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });

  late String toId;
  late int id;
  late String msg;
  late String read;
  late String fromId;
  late String sent;
  late Type type;

  Message.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    id = json['id'];
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json['fromId'].toString();
    sent = json['sent'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['id'] = id;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    return data;
  }
}

enum Type { text, image }