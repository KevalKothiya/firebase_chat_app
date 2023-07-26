import 'package:firebase_chat_app/controllers/dark_theme_gc.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingChats extends StatefulWidget {
  const SettingChats({Key? key}) : super(key: key);

  @override
  State<SettingChats> createState() => _SettingChatsState();
}

class _SettingChatsState extends State<SettingChats> {
  DarkMode_GetxController darkController = Get.put(DarkMode_GetxController());
  User_GetxController userController = Get.put(User_GetxController());

  EdgeInsets padding = EdgeInsets.all(2.h);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          backgroundColor: (darkController.darkModeModel.isDarkMode)
              ? CupertinoColors.black
              : CupertinoColors.systemGrey6,
          largeTitle: Text(
            'Chats',
            style: TextStyle(
              color: (darkController.darkModeModel.isDarkMode)
                  ? CupertinoColors.white
                  : CupertinoColors.black,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: (darkController.darkModeModel.isDarkMode)
                ? CupertinoColors.black
                : CupertinoColors.systemGrey6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  container(context: "Chat Wallpaper", onTap: null),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Save Method",
                        style: (darkController.darkModeModel.isDarkMode)
                            ? TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 4.w,
                                decoration: TextDecoration.none,
                              )
                            : TextStyle(
                                color: CupertinoColors.black,
                                fontSize: 4.w,
                                decoration: TextDecoration.none,
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.1.h,
                  ),
                  Card(
                    color: (darkController.darkModeModel.isDarkMode)
                        ? CupertinoColors.darkBackgroundGray
                        : CupertinoColors.white,
                    child: CupertinoListTile(
                      title: Text(
                        "Save to Camera Roll",
                        style: TextStyle(
                          color: (darkController.darkModeModel.isDarkMode)
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: CupertinoColors.systemBlue,
                        value: false,
                        onChanged: null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: padding.copyWith(left: 8.w,bottom: 0.h,top: 0.h),
                    child: Text(
                      "Automatically save photos and videos you receive to your iPhone's Camera Roll.",
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 3.w,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Card(
                    child: CupertinoListSection(
                      backgroundColor: (darkController.darkModeModel.isDarkMode)
                          ? CupertinoColors.black
                          : CupertinoColors.white,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.2.h),
                        color: (darkController.darkModeModel.isDarkMode)
                            ? Colors.grey.shade900
                            : Colors.white.withOpacity(0.5),
                      ),
                      header: const Text("SHARE"),
                      children: [
                        container(
                          context: "Chat Backup",
                          onTap: null,
                        ),
                        container(
                          context: "Export Chat",
                          onTap: null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),

                  Card(
                    color: (darkController.darkModeModel.isDarkMode)
                        ? CupertinoColors.darkBackgroundGray
                        : CupertinoColors.white,
                    child: CupertinoListTile(
                      title: Text(
                        "Keep Chats Archived",
                        style: TextStyle(
                          color: (darkController.darkModeModel.isDarkMode)
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: CupertinoColors.activeGreen,
                        value: true,
                        onChanged: null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: padding.copyWith(left: 8.w,bottom: 0.h,top: 0.h),
                    child: Text(
                      "Archived chats will remain archived when you receive a new message.",
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 3.w,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Card(
                    child: CupertinoListSection(
                      backgroundColor: (darkController.darkModeModel.isDarkMode)
                          ? CupertinoColors.black
                          : CupertinoColors.white,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.2.h),
                        color: darkController.darkModeModel.isDarkMode
                            ? Colors.grey.shade900
                            : Colors.white.withOpacity(0.5),
                      ),
                      header: const Text("TRANSFER"),
                      children: [
                        container1(
                          context: "Move Chats to Android",
                          onTap: null,
                        ),
                        container1(
                          context: "Transfer Chats to iPhone",
                          onTap: null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Card(
                    child: CupertinoListSection(
                      backgroundColor: (darkController.darkModeModel.isDarkMode)
                          ? CupertinoColors.black
                          : CupertinoColors.white,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.2.h),
                        color: darkController.darkModeModel.isDarkMode
                            ? Colors.grey.shade900
                            : Colors.white.withOpacity(0.5),
                      ),
                      header: const Text("SAVE OR DELETE"),
                      children: [
                        container1(
                          context: "Archive All Chats",
                          onTap: null,
                        ),
                        container1(
                          context: "Clear All Chats",
                          color: CupertinoColors.systemRed,
                          onTap: null,
                        ),
                        container1(
                          context: "Delete All Chats",
                          color: CupertinoColors.systemRed,
                          onTap: null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget container({
    required String context,

    required onTap,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: (darkController.darkModeModel.isDarkMode)
              ? CupertinoColors.black
              : CupertinoColors.white,
          border: Border.all(
            color: (darkController.darkModeModel.isDarkMode)
                ? CupertinoColors.black
                : CupertinoColors.systemGrey6,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text(
              context,
              style: (darkController.darkModeModel.isDarkMode)
                  ? TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 3.5.w,
                      decoration: TextDecoration.none,
                    )
                  : TextStyle(
                      color: CupertinoColors.black,
                      fontSize: 3.5.w,
                      decoration: TextDecoration.none,
                    ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Icon(
              CupertinoIcons.forward,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget container1({
    required String context, Color color = CupertinoColors.activeBlue,
    required onTap,
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: (darkController.darkModeModel.isDarkMode)
              ? CupertinoColors.black
              : CupertinoColors.white,
          border: Border.all(
            color: (darkController.darkModeModel.isDarkMode)
                ? CupertinoColors.black
                : CupertinoColors.systemGrey6,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              child: Text(
                context,
                style: TextStyle(
                        color: color,
                        fontSize: 3.5.w,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
