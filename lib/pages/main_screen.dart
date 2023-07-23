import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/controllers/log_in_out_gc.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
import 'package:firebase_chat_app/helper/cloud_firestore_helper.dart';
import 'package:firebase_chat_app/helper/firebase_auth_helper.dart';
import 'package:firebase_chat_app/pages/menu_widget.dart';
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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    CFSHelper.cfsHelper.diplayCurrentUser();
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
              icon: Icon(Icons.logout))
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
                            Get.toNamed('/chat_page', arguments: data[i]);
                          },
                          leading: CachedNetworkImage(
                            imageUrl: data[i].data()['image'],
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                                  foregroundImage:
                                  NetworkImage(data[i].data()['image']),
                                ),
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          title: Text(data[i].data()['name']),
                          subtitle: Text(data[i].data()['id']),
                          isThreeLine: true,
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
}