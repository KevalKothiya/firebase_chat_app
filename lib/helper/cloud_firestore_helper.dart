import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/helper/cloud_messaing_notification.dart';
import 'package:firebase_chat_app/helper/fcm_messaging_helper.dart';
import 'package:firebase_chat_app/helper/firebase_auth_helper.dart';
import 'package:firebase_chat_app/modals/global/chat_user.dart';
import 'package:firebase_chat_app/modals/global/message_data.dart';
import 'package:get/get.dart';

class CFSHelper {
  /*CFSH = Cloud FireStore Helper*/
  CFSHelper._();

  static final CFSHelper cfsHelper = CFSHelper._();

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User auth = FirebaseAuth.instance.currentUser!;
  late CollectionReference userReference;
  late CollectionReference messageReference;

  void connectWithCollection() async {
    userReference = firestore.collection('users');
    messageReference = firestore.collection('message');
  }

  Stream<QuerySnapshot> diplayAllRecode() {
    connectWithCollection();
    return userReference.where('id', isNotEqualTo: auth.uid).snapshots();
  }

  Stream<QuerySnapshot> diplayCurrentUser() {
    connectWithCollection();

    return userReference.where('id', isEqualTo: auth.uid).snapshots();
  }

  Future<bool> userExits() async {
    connectWithCollection();

    return (await userReference
            .doc(FBHelper.firebaseAuth.currentUser!.uid)
            .get())
        .exists;
  }

  Future<void> createUser({String? name, String? phoneNumber}) async {
    connectWithCollection();
    String? token = await FCMHelper.fcmHelper.fetchTokan();
    log(token.toString());

    final chatUser = ChatUser(
      image: auth.photoURL.toString(),
      about: "about",
      name: (auth.displayName.isNull) ? name! : auth.displayName.toString(),
      createdAt: FieldValue.serverTimestamp().toString(),
      isOnline: false,
      id: auth.uid,
      lastActive: FieldValue.serverTimestamp().toString(),
      email: auth.email.toString(),
      phone: (auth.phoneNumber.isNull)
          ? (phoneNumber == null) ?"9231578230":phoneNumber
          : auth.phoneNumber.toString(),
      pushToken: token.toString(),
    );

    await userReference.doc(auth.uid).set(chatUser.toFirebase());
  }

  String getConersationID(String id) => (auth.uid.hashCode <= id.hashCode)
      ? '${auth.uid}_$id'
      : '${id}_${auth.uid}';

  Stream<QuerySnapshot> displayAllMessages(Map<String, dynamic> user) {
    connectWithCollection();
    String id = getConersationID(user['id']);

    return firestore
        .collection('chat/${id}/messages/')
        .orderBy("sent", descending: true)
        .snapshots();
  }

  Future<void> sendMessage(
      {required Map<String, dynamic> user, required String msg}) async {
    connectWithCollection();
    String id = getConersationID(user['id']);
    FieldValue time = FieldValue.serverTimestamp();

    DocumentSnapshot<Map<String, dynamic>> data =
        await firestore.collection('chatRecode').doc("chat").get();

    Map<String, dynamic> ss = data.data() as Map<String, dynamic>;

    int recodeId = ss['id'];

    final ref = firestore.collection('chat/${id}/messages/');

    DateTime senderTime = DateTime.now();

    await firestore.collection("chatRecode").doc("chat").update({"id": ++recodeId});

    final message = Message(
        msg: msg,
        id: recodeId,
        read: "read",
        fromId: auth.uid,
        toId: user['id'],
        type: Type.text,
        sent: senderTime.toString());

    await ref.doc("${recodeId}").set(message.toJson()).then((value) => CMFBHelper.cmfbHelper.sendCMbyApi(user: user, msg: msg));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> displaySentLastMessage({required Map<String, dynamic> user}) {
    return firestore.collection("chat/${getConersationID(user['id'])}/messages/").orderBy('sent', descending: true).limit(1).snapshots();
  }

  Future<void> deletePerticularMessage(
      {required Map<String, dynamic> user, required String messageId}) async {
    connectWithCollection();
    String id = getConersationID(user['id']);
    await firestore.collection('chat/${id}/messages/').doc(messageId).delete();
  }

  Future<void> updateDisplayName({required User user, required String name}) async {
    await user.updateDisplayName(name);
  }

  Future<void> updateEmail({required User user, required String email}) async {
    await user.updateEmail(email);
  }

  Future<void> updatePassword({required User user, required String password}) async {
    await user.updatePassword(password);
  }
}
