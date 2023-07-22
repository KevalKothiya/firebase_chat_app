import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
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
  User_GetxController user_getxController = Get.put(User_GetxController());

  TextEditingController textEditingController = TextEditingController();

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
            icon: Icon(
              CupertinoIcons.back,
            ),
          ),
          flexibleSpace: flexibleSpace(ss: model),
        ),
        body: Container(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream:
                        CFSHelper.cfsHelper.displayAllMessages(model.data()),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error :${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        QuerySnapshot<Map<String, dynamic>>? data = snapshot
                            .data as QuerySnapshot<Map<String, dynamic>>?;
                        List<QueryDocumentSnapshot<Map<String, dynamic>>> ss =
                            data!.docs;

                        return (ss.isEmpty)
                            ? Center(
                                child: Text("Empty"),
                              )
                            : ListView.builder(
                                itemCount: ss.length,
                                reverse: true,
                                itemBuilder: (context, i) {
                                  return (ss[i].data()['fromId'] ==
                                          CFSHelper.auth.uid)
                                      ? me(ss: ss[i].data())
                                      : you(ss: ss[i].data());
                                });

                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        CupertinoIcons.add,
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textEditingController,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Types here...",
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    (textEditingController.text.isEmpty)
                        ? Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.paypal,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.keyboard_voice_outlined,
                                ),
                              ),
                            ],
                          )
                        : CircleAvatar(
                            child: IconButton(
                            onPressed: () async {
                              await CFSHelper.cfsHelper.sendMessage(
                                  user: model.data(),
                                  msg: textEditingController.text);

                              textEditingController.clear();
                            },
                            icon: Icon(
                              Icons.send,
                            ),
                          ))
                  ]),
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
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
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
              Text("Last Time")
            ],
          ),
          Spacer(),
          Transform.scale(
              scale: 1.5,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.video_camera,
                ),
              )),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.phone,
            ),
          ),
        ],
      ),
    );
  }

  Widget me({
    required ss,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 13.w,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.5.w)),
          color: Color(0xffdcf8c6),
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
                  ),
                ),
              ),
              Positioned(
                bottom: 0.4.h,
                right: 2.w,
                child: Row(
                  children: [
                    time(
                      time: ss['sent'],
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Icon(
                      Icons.done_all,
                      size: 5.w,
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

  Widget you({
    required ss,
}){
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 13.w,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.5.w)),
          // color: Color(0xffdcf8c6),
          margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
          child: Stack(
            children: [
              Padding(
                padding:  EdgeInsets.only(
                  left: 1.5.w,
                  right: 10.w,
                  top: 0.6.h,
                  bottom: 1.6.h,
                ),
                child: Text(
                  ss['msg'],
                  style: TextStyle(
                    fontSize: 4.1.w,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.4.h,
                right: 2.w,
                child: time(
                  time: ss['sent'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget time({required String time}) {
    DateTime tempDate = DateTime.parse(time);
    return (time.isNull)
        ? Container()
        : RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${tempDate.hour.toString()}:",
                  style: TextStyle(color: Colors.black, fontSize: 1.3.h),
                ),
                TextSpan(
                  text: tempDate.minute.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 1.3.h),
                ),
              ],
            ),
          );
  }
}
