import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/controllers/dark_theme_gc.dart';
import 'package:firebase_chat_app/controllers/log_in_out_gc.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
import 'package:firebase_chat_app/helper/cloud_firestore_helper.dart';
import 'package:firebase_chat_app/helper/fcm_messaging_helper.dart';
import 'package:firebase_chat_app/helper/firebase_auth_helper.dart';
import 'package:firebase_chat_app/modals/global/message_data.dart';
import 'package:firebase_chat_app/pages/menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User_GetxController user_getxController = Get.put(User_GetxController());
  Google_login_out_GetController google_login_out_getController =
      Get.put(Google_login_out_GetController());

  DarkMode_GetxController darkController = Get.put(DarkMode_GetxController());
  Message? message;
  Message? message2;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    CFSHelper.cfsHelper.diplayAllRecode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Started"),
        leading: MenuWidget(),
        actions: [
          IconButton(
              onPressed: () async {
                await FBHelper.fbHelper.signOut();
                google_login_out_getController.falseValue();
                Get.offAllNamed("/login_page");
              },
              icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () async {
                FCMHelper.fcmHelper.fetchTokan();
              },
              icon: Icon(Icons.token))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(1.2.h),
        child: StreamBuilder(
            stream: CFSHelper.cfsHelper.diplayAllRecode(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error :${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                QuerySnapshot<Map<String, dynamic>> ss =
                    snapshot.data as QuerySnapshot<Map<String, dynamic>>;

                List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                    ss.docs;

                return (data.isEmpty)
                    ? const Center(
                        child: Text("Empty"),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Get.toNamed('/chat_page',
                                    arguments: data[i]);
                              },
                              leading: CachedNetworkImage(
                                imageUrl: data[i].data()['image'],
                                imageBuilder:
                                    (context, imageProvider) =>
                                    CircleAvatar(
                                      foregroundImage: NetworkImage(
                                          data[i].data()['image']),
                                    ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget:
                                    (context, url, error) =>
                                    Icon(Icons.person),
                              ),
                              title: Text(data[i].data()['name']),
                              subtitle: StreamBuilder(
                                  stream: CFSHelper.cfsHelper
                                      .displaySentLastMessage(
                                      user: data[i].data()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                            "Error :${snapshot.error}"),
                                      );
                                    } else if (snapshot.hasData) {
                                      QuerySnapshot<
                                          Map<String,
                                              dynamic>> ss2 =
                                      snapshot.data
                                      as QuerySnapshot<
                                          Map<String,
                                              dynamic>>;

                                      List<
                                          QueryDocumentSnapshot<
                                              Map<String,
                                                  dynamic>>>
                                      data2 = ss2.docs;

                                      final list = data2
                                          .map((e) => Message
                                          .fromJson(
                                          e.data()))
                                          .toList() ??
                                          [];

                                      if (list.isNotEmpty) {
                                        message = list[0];
                                      }

                                      return (data2.isEmpty)
                                          ? Text(data[i]
                                          .data()[
                                      'about'])
                                          : message !=
                                          null
                                          ? Text(message!
                                          .msg)
                                          : Text(data[i]
                                          .data()[
                                      'about']);
                                    }
                                    return Center(
                                      child:
                                      CircularProgressIndicator(),
                                    );
                                  }),
                              isThreeLine: true,
                              // trailing: StreamBuilder(
                              //     stream: CFSHelper.cfsHelper
                              //         .displaySentLastMessage(
                              //         user: data[i].data()),
                              //     builder: (context, as) {
                              //       if (as.hasError) {
                              //         return Center(
                              //           child: Text(
                              //               "Error :${as.error}"),
                              //         );
                              //       } else if (as.hasData) {
                              //         QuerySnapshot<
                              //             Map<String,
                              //                 dynamic>> ss3 =
                              //         as.data
                              //         as QuerySnapshot<
                              //             Map<String,
                              //                 dynamic>>;
                              //
                              //         List<
                              //             QueryDocumentSnapshot<
                              //                 Map<String,
                              //                     dynamic>>>
                              //         data3 = ss3.docs;
                              //
                              //         final list = data3
                              //             .map((e) => Message
                              //             .fromJson(
                              //             e.data()))
                              //             .toList() ?? [];
                              //
                              //         if (list.isNotEmpty) {
                              //           message2 = list[0];
                              //         }
                              //
                              //         return (data3.isEmpty)
                              //             ? Text("")
                              //             : message2 != null ? time(time: message2!.sent): time(time: data[i].data()['sent']);
                              //       }
                              //       return Center(
                              //         child:
                              //         CircularProgressIndicator(),
                              //       );
                              //     }),
                            ),
                          );
                        });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
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
            text: "${tempDate.day.toString()} ",
            style: TextStyle(
                color: (darkController.darkModeModel.isDarkMode)
                    ? CupertinoColors.white
                    : Colors.black,
                fontSize: 1.8.h),
          ),
          TextSpan(
            text: convert(time: tempDate),
            style: TextStyle(
                color: (darkController.darkModeModel.isDarkMode)
                    ? CupertinoColors.white
                    : CupertinoColors.black,
                fontSize: 1.8.h),
          ),
        ],
      ),
    );
  }

  String convert({required DateTime time}){
    switch (time.month){
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      default:
        return "Dec";
    }
  }
}
