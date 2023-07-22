import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/modals/global/chat_user.dart';
import 'package:firebase_chat_app/modals/util/utils.dart';
import 'package:get/get.dart';

class ChatUser_GetxController extends GetxController {
  ChatUser chatUser = ChatUser(
    image: box.read('image') ?? "",
    about: box.read('about') ?? "",
    name: box.read('name') ?? "",
    createdAt: box.read('createdAt') ?? "",
    isOnline: box.read('isOnline') ?? false,
    id: box.read('id') ?? "",
    lastActive: box.read('lastActive') ?? "",
    email: box.read('email') ?? "",
    phone: box.read('phone') ?? "",
    pushToken: box.read('pushToken') ?? "",
  );

  initializedValue({required List<QueryDocumentSnapshot<Map<String, dynamic>>> val}) {
    val.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

    box.write('image', chatUser.image);
    box.write('about', chatUser.about);
    box.write('name', chatUser.name);
    box.write('createdAt', chatUser.createdAt);
    box.write('isOnline', chatUser.isOnline);
    box.write('id', chatUser.id);
    box.write('lastActive', chatUser.lastActive);
    box.write('email', chatUser.email);
    box.write('phone', chatUser.phone);
    box.write('pushToken', chatUser.pushToken);

    update();
  }
}
