import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/controllers/dark_theme_gc.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
import 'package:firebase_chat_app/helper/cloud_firestore_helper.dart';
import 'package:firebase_chat_app/helper/fcm_messaging_helper.dart';
import 'package:firebase_chat_app/pages/menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userToken;
  TextEditingController displayNameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  User_GetxController userController = Get.put(User_GetxController());
  DarkMode_GetxController darkController = Get.put(DarkMode_GetxController());

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    userToken = await FCMHelper.fcmHelper.fetchTokan();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile Page"),
          leading: const MenuWidget(),
        ),
        body: StreamBuilder(
            stream: CFSHelper.cfsHelper.diplayCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error :${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                QuerySnapshot<Map<String, dynamic>> ss =
                    snapshot.data as QuerySnapshot<Map<String, dynamic>>;

                List<QueryDocumentSnapshot<Map<String, dynamic>>> current =
                    ss.docs;
                userController.initialization(
                    email: current[0].data()['email'],
                    uid: current[0].data()['id'],
                    displayName: current[0].data()['name'],
                    token: userToken!,
                    photoURl: current[0].data()['image']);
                return (current.isEmpty)
                    ? const Center(
                        child: Text("Empty"),
                      )
                    : GetBuilder<User_GetxController>(builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(2.h),
                          child: Column(
                            children: [
                              Stack(
                                alignment: const Alignment(1, 0.8),
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        userController.user_model.photoURl,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 20.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(userController
                                              .user_model.photoURl),
                                          fit: BoxFit.cover,
                                          colorFilter: const ColorFilter.mode(
                                            Colors.red,
                                            BlendMode.colorBurn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  const CircleAvatar(
                                    child: IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.camera),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(userController.user_model.email),
                              SizedBox(
                                height: 4.h,
                              ),
                              listTile(
                                leading: Icons.person,
                                onPressed: () async {
                                  Get.dialog(
                                    CupertinoAlertDialog(
                                      title: const Text("Update DisplayName"),
                                      content: Form(
                                        key: globalKey,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 1.0.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 7.w),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Display Name  :",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            CupertinoTextFormFieldRow(
                                              controller: displayNameController,
                                              style: TextStyle(
                                                color: (darkController
                                                        .darkModeModel
                                                        .isDarkMode)
                                                    ? CupertinoColors.white
                                                    : CupertinoColors.black,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.w),
                                                  border: Border.all(
                                                      color: (darkController
                                                              .darkModeModel
                                                              .isDarkMode)
                                                          ? CupertinoColors
                                                              .white
                                                          : CupertinoColors
                                                              .black)),
                                              placeholder: "Enter name here...",
                                              validator: (val) {
                                                return (val!.isEmpty)
                                                    ? "Enter DisplayName first..."
                                                    : null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          isDefaultAction: true,
                                          onPressed: () async {
                                            Get.back();
                                          },
                                          child: const Text("Update"),
                                        ),
                                        CupertinoDialogAction(
                                          isDestructiveAction: true,
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Cansel"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                title: "Name",
                                subtitle: userController.user_model.displayName,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Text(
                                    "This is not your username or pin. This name will be visible to your Whatsapp contact.",
                                    style: TextStyle(
                                        fontSize: 1.4.h, color: Colors.grey),
                                  )),
                              SizedBox(
                                height: 2.h,
                              ),
                              listTile(
                                leading: Icons.info_outline,
                                title: "About",
                                subtitle: userController.user_model.about,
                                onPressed: () async {
                                  Get.dialog(
                                    CupertinoAlertDialog(
                                      title: const Text("Update About"),
                                      content: Form(
                                        key: globalKey,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 1.0.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 7.w),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "About :",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            CupertinoTextFormFieldRow(
                                              controller: aboutController,
                                              style: TextStyle(
                                                color: (darkController
                                                        .darkModeModel
                                                        .isDarkMode)
                                                    ? CupertinoColors.white
                                                    : CupertinoColors.black,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.w),
                                                  border: Border.all(
                                                      color: (darkController
                                                              .darkModeModel
                                                              .isDarkMode)
                                                          ? CupertinoColors
                                                              .white
                                                          : CupertinoColors
                                                              .black)),
                                              placeholder:
                                                  "Enter about here...",
                                              validator: (val) {
                                                return (val!.isEmpty)
                                                    ? "Enter about section first..."
                                                    : null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          isDefaultAction: true,
                                          onPressed: () async {
                                            if (globalKey.currentState!
                                                .validate()) {
                                              globalKey.currentState!.save();
                                              Get.back();
                                              userController.user_model.about =
                                                  aboutController.text;
                                              aboutController.clear();
                                            }
                                          },
                                          child: const Text("Update"),
                                        ),
                                        CupertinoDialogAction(
                                          isDestructiveAction: true,
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Cansel"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              listTile(
                                leading: Icons.call,
                                title: "Phone",
                                subtitle: userController.user_model.phoneNumber,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        );
                      });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  Widget listTile({
    required IconData leading,
    required String title,
    required String subtitle,
    required onPressed,
  }) {
    return ListTile(
      leading: Icon(leading),
      title: Text(title, style: const TextStyle(color: Colors.grey)),
      subtitle: Text(subtitle),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Icons.edit)),
    );
  }
}
