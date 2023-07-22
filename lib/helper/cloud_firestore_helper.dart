import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/controllers/chat_user_gc.dart';
import 'package:firebase_chat_app/helper/fcm_messaging_helper.dart';
import 'package:firebase_chat_app/helper/firebase_auth_helper.dart';
import 'package:firebase_chat_app/modals/global/chat_user.dart';
import 'package:firebase_chat_app/modals/global/message_data.dart';

class CFSHelper {
  /*CFSH = Cloud FireStore Helper*/
  CFSHelper._();

  static final CFSHelper cfsHelper = CFSHelper._();

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User auth = FirebaseAuth.instance.currentUser!;
  late CollectionReference userReference;
  late CollectionReference messageReference;

  void connectWithCollection() async {
    log(auth.phoneNumber.toString());
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

  Future<void> createUser() async {
    connectWithCollection();

    final chatUser = ChatUser(
      image: auth.photoURL.toString(),
      about: "about",
      name: auth.displayName.toString(),
      createdAt: FieldValue.serverTimestamp().toString(),
      isOnline: false,
      id: auth.uid,
      lastActive: FieldValue.serverTimestamp().toString(),
      email: auth.email.toString(),
      phone: auth.phoneNumber.toString(),
      pushToken: FCMHelper.fcmHelper.fetchTokan().toString(),
    );


    await userReference.doc(auth.uid).set(chatUser.toFirebase());
  }
  
  String getConersationID(String id) => (auth.uid.hashCode <= id.hashCode ) ? '${auth.uid}_$id' : '${id}_${auth.uid}';

  Stream<QuerySnapshot> displayAllMessages(Map<String, dynamic> user) {
    connectWithCollection();
     String id = getConersationID(user['id']);
    
    return firestore.collection('chat/${id}/messages/').orderBy("sent", descending: true).snapshots();
  }
  
  

  Future<void> sendMessage({required Map<String, dynamic> user, required String msg}) async {
    connectWithCollection();
    String id = getConersationID(user['id']);
     FieldValue time = FieldValue.serverTimestamp();
    log("time :${time.toString()}");
    
    final ref = firestore.collection('chat/${id}/messages/');

    DateTime senderTime = DateTime.now();

    final  message = Message(
        msg: msg,
        read: "read",
        fromId: auth.uid,
        toId: user['id'],
        type: Type.text,
        sent: senderTime.toString()
    );

    await ref.doc(DateTime.now().toString()).set(message.toJson());


    // await messageReference.doc(auth.uid).set(message.toJson());
  }
}
