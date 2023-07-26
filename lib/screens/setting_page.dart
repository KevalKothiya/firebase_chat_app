import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_chat_app/controllers/dark_theme_gc.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
import 'package:firebase_chat_app/pages/menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
          leading: MenuWidget(),
          largeTitle: Text(
            'Developer',
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
                  CupertinoListTile.notched(
                    padding: padding,
                    backgroundColor: (darkController.darkModeModel.isDarkMode)
                        ? CupertinoColors.black
                        : CupertinoColors.white,
                    leadingSize: 15.w,
                    leading: CachedNetworkImage(
                      imageUrl: userController.user_model.photoURl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 20.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  userController.user_model.photoURl),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.red, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: Text(
                      userController.user_model.displayName,
                      style: TextStyle(
                        color: (darkController.darkModeModel.isDarkMode)
                            ? CupertinoColors.white
                            : CupertinoColors.black,
                      ),
                    ),
                    subtitle: Text(userController.user_model.about),
                    trailing: CircleAvatar(
                      radius: 4.w,
                      child: Icon(CupertinoIcons.qrcode),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "APPEARANCE",
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
                    height: 1.h,
                  ),
                  Card(
                    color: (darkController.darkModeModel.isDarkMode)
                        ? CupertinoColors.darkBackgroundGray
                        : CupertinoColors.white,
                    child: CupertinoListTile(
                      title: Text(
                        "Dark Apperarance",
                        style: TextStyle(
                          color: (darkController.darkModeModel.isDarkMode)
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: CupertinoColors.systemBlue,
                        value: darkController.darkModeModel.isDarkMode,
                        onChanged: (val) {
                          setState(() {
                            darkController.darkThemeUDF(val: val);
                          });
                        },
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
                      header: const Text("DISPLAY VIEW"),
                      footer: Text(
                        "Choose a view for iphone. Zoomed shadows larger controls. Standart shows more content.",
                        style: (darkController.darkModeModel.isDarkMode)
                            ? TextStyle(
                                color: CupertinoColors.systemGrey2,
                                fontSize: 1.5.h)
                            : TextStyle(
                                color: CupertinoColors.systemGrey2,
                                fontSize: 1.5.h,
                              ),
                      ),
                      children: [
                        container(
                          containerColor: CupertinoColors.systemBlue,
                          icon: Icons.person,
                          context: "Avatar",
                          onTap: null,
                        ),
                        container(
                          containerColor: CupertinoColors.systemYellow,
                          icon: Icons.star,
                          context: "Starred Messages",
                          onTap: null,
                        ),
                        container(
                          containerColor: CupertinoColors.systemGreen,
                          icon: Icons.link,
                          context: "Linked Devices",
                          onTap: null,
                        ),
                      ],
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
                      header: const Text("UI AUTOMATION"),
                      children: [
                        container(
                          containerColor: CupertinoColors.systemBlue,
                          icon: Icons.key,
                          context: "Account",
                          onTap: null,
                        ),
                        container(
                          containerColor: CupertinoColors.systemCyan,
                          icon: Icons.lock,
                          context: "Account",
                          onTap: null,
                        ),
                        container(
                          containerColor: CupertinoColors.systemGreen,
                          icon: CupertinoIcons.chat_bubble_2_fill,
                          context: "Chats",
                          onTap: (){
                            print("tapped");
                            Get.toNamed('setting_chat_page');
                            print("tapped2");
                          },
                        ),
                        container(
                          containerColor: CupertinoColors.systemRed,
                          icon: CupertinoIcons.app_badge_fill,
                          context: "Notifications",
                          onTap: null,
                        ),
                        container(
                          containerColor: CupertinoColors.systemCyan,
                          icon: Icons.currency_rupee,
                          context: "Payments",
                          onTap: null,
                        ),
                        container(
                          containerColor: CupertinoColors.systemGreen,
                          icon: CupertinoIcons.arrow_up_down,
                          context: "Account",
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
    required Color containerColor,
    required IconData icon,
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
            height: 3.3.h,
            width: 7.2.w,
            // padding: padding,
            decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(1.w)),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: CupertinoColors.white,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
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
}
