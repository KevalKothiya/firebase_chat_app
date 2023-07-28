// ignore_for_file: deprecated_member_use
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/controllers/dark_theme_gc.dart';
import 'package:firebase_chat_app/controllers/textediter_gc.dart';
import 'package:firebase_chat_app/helper/cloud_firestore_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  DarkMode_GetxController darkController = Get.put(DarkMode_GetxController());
  TextEditingController_GetxController textController =
      Get.put(TextEditingController_GetxController());

  Color iconColor = const Color(0xff3a90df);

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot<Map<String, dynamic>> model = ModalRoute.of(context)!
        .settings
        .arguments as QueryDocumentSnapshot<Map<String, dynamic>>;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              CupertinoIcons.back,
            ),
          ),
          flexibleSpace: flexibleSpace(ss: model),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (darkController.darkModeModel.isDarkMode)
                  ? const AssetImage("assets/images/dark_chat_wallpaper.jpg")
                  : const AssetImage("assets/images/light_chat_wallpaper.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: CFSHelper.cfsHelper.displayAllMessages(
                    model.data(),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error :${snapshot.error}",
                        ),
                      );
                    } else if (snapshot.hasData) {
                      QuerySnapshot<Map<String, dynamic>>? data =
                          snapshot.data as QuerySnapshot<Map<String, dynamic>>?;
                      List<QueryDocumentSnapshot<Map<String, dynamic>>> ss =
                          data!.docs;
                      return (ss.isEmpty)
                          ? const Center(
                              child: Text("Empty"),
                            )
                          : ListView.builder(
                              itemCount: ss.length,
                              padding: EdgeInsets.all(2.h),
                              reverse: true,
                              itemBuilder: (context, i) {
                                return (ss[i].data()['fromId'] ==
                                        CFSHelper.auth.uid)
                                    ? me(
                                        ss: ss[i].data(),
                                        data: model.data(),
                                        who: true)
                                    : you(
                                        ss: ss[i].data(),
                                        data: model.data(),
                                        who: false);
                              },
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Container(
                color: darkController.darkModeModel.isDarkMode
                    ? const Color(0xff171717)
                    : const Color(0xfff6f6f6),
                padding: EdgeInsets.all(2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        CupertinoIcons.add,
                        color: iconColor,
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextFormField(
                                onTap: () {
                                  textController.convertIntoTrue();
                                },
                                controller:
                                    textController.textEditingController,
                                decoration: const InputDecoration.collapsed(
                                    hintText: " Types here...",
                                    border: InputBorder.none),
                                validator: (val) => (val!.isNotEmpty)
                                    ? null
                                    : "Enter message first",
                              ),
                            ),
                            IconButton(
                              onPressed: null,
                              icon: Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: iconColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    (textController.isTyping == false)
                        ? Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.paypal,
                                  color: iconColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera,
                                  color: iconColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.keyboard_voice_outlined,
                                  color: iconColor,
                                ),
                              ),
                            ],
                          )
                        : CircleAvatar(
                            child: IconButton(
                              onPressed: () async {
                                await CFSHelper.cfsHelper.sendMessage(
                                    user: model.data(),
                                    msg: textController
                                        .textEditingController.text);
                                textController.clearMethod();
                                textController.convertIntoFalse();
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.send,
                                color: iconColor,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget flexibleSpace({required ss}) {
    return Container(
      padding: EdgeInsets.only(top: 0.6.h, left: 6.h),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: ss.data()['image'],
            imageBuilder: (context, imageProvider) => CircleAvatar(
              foregroundImage: NetworkImage(ss.data()['image']),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.person),
          ),
          SizedBox(
            width: 2.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 0.5.h,
              ),
              Text(ss.data()['name']),
              // Text(ss[0].data()['last_active']),
              const Text("Last Time")
            ],
          ),
          const Spacer(),
          Transform.scale(
              scale: 1.5,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.video_camera,
                ),
              )),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.phone,
            ),
          ),
        ],
      ),
    );
  }

  Widget me({
    required ss,
    required Map<String, dynamic> data,
    required bool who,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onLongPress: () {
          Get.dialog(
            CupertinoAlertDialog(
              title: const Text("Delete Message"),
              actions: [
                CupertinoDialogAction(
                  child: const Text("Delete"),
                  onPressed: () async {
                    Get.back();
                    await CFSHelper.cfsHelper.deletePerticularMessage(
                        user: data, messageId: ss['id'].toString());
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("Cansel"),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 13.w,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.5.w)),
            color: darkController.darkModeModel.isDarkMode
                ? const Color(0xff0f5348)
                : const Color(0xffdcf8c6),
            margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 2.6.w,
                    right: 10.w,
                    top: 0.7.h,
                    bottom: 2.2.h,
                  ),
                  child: Text(
                    ss['msg'],
                    style: TextStyle(
                        fontSize: 4.w,
                        color: darkController.darkModeModel.isDarkMode
                            ? CupertinoColors.white
                            : CupertinoColors.black),
                  ),
                ),
                Positioned(
                  bottom: 0.4.h,
                  right: 2.w,
                  child: Row(
                    children: [
                      time(
                        time: ss['sent'],
                        who: who,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Icon(Icons.done_all,
                          size: 5.w,
                          color: (darkController.darkModeModel.isDarkMode)
                              ? const Color(0xff59a098)
                              : const Color(0xff98b08c)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget you({
    required ss,
    required Map<String, dynamic> data,
    required bool who,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          Get.dialog(
            CupertinoAlertDialog(
              title: const Text("Delete Message"),
              actions: [
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () async {
                    Get.back();
                    await CFSHelper.cfsHelper.deletePerticularMessage(
                        user: data, messageId: ss['id'].toString());
                  },
                  child: const Text("Delete"),
                ),
                CupertinoDialogAction(
                  child: const Text("Cansel"),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 13.w,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.5.w)),
            color: darkController.darkModeModel.isDarkMode
                ? const Color(0xff3c3c3e)
                : CupertinoColors.white,
            margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 1.5.w,
                    right: 10.w,
                    top: 0.6.h,
                    bottom: 1.6.h,
                  ),
                  child: Text(
                    ss['msg'],
                    style: TextStyle(
                      fontSize: 4.1.w,
                      color: darkController.darkModeModel.isDarkMode
                          ? CupertinoColors.white
                          : CupertinoColors.black,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.4.h,
                  right: 2.w,
                  child: time(
                    time: ss['sent'],
                    who: who,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget time({required String time, required bool who}) {
    DateTime tempDate = DateTime.parse(time);
    return (time.isNull)
        ? Container()
        : (who)
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${tempDate.hour.toString()}:",
                      style: TextStyle(
                          color: (darkController.darkModeModel.isDarkMode)
                              ? const Color(0xff59a098)
                              : const Color(0xff98b08c),
                          fontSize: 1.3.h),
                    ),
                    TextSpan(
                      text: tempDate.minute.toString(),
                      style: TextStyle(
                          color: (darkController.darkModeModel.isDarkMode)
                              ? const Color(0xff59a098)
                              : const Color(0xff98b08c),
                          fontSize: 1.3.h),
                    ),
                  ],
                ),
              )
            : RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${tempDate.hour.toString()}:",
                      style: TextStyle(
                          color: (darkController.darkModeModel.isDarkMode)
                              ? const Color(0xff7a797c)
                              : const Color(0xffcacaca),
                          fontSize: 1.3.h),
                    ),
                    TextSpan(
                      text: tempDate.minute.toString(),
                      style: TextStyle(
                          color: (darkController.darkModeModel.isDarkMode)
                              ? const Color(0xff7a797c)
                              : const Color(0xffcacaca),
                          fontSize: 1.3.h),
                    ),
                  ],
                ),
              );
  }
}
