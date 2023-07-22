import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/controllers/log_in_out_gc.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
import 'package:firebase_chat_app/helper/cloud_firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User_GetxController user_getxController = Get.put(User_GetxController());
  Google_login_out_GetController google_login_out_getController =
      Get.put(Google_login_out_GetController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile Page"),
        ),
        body: GetBuilder<User_GetxController>(
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(2.h),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment(1, 0.8),
                    children: [
                      CachedNetworkImage(
                        imageUrl: user_getxController.user_model.photoURl,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 20.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    user_getxController.user_model.photoURl),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.red, BlendMode.colorBurn)),
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      CircleAvatar(
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
                  Text(user_getxController.user_model.email),
                  SizedBox(
                    height: 4.h,
                  ),
                  listTile(leading: Icons.person,onPressed: null, title: "Name",subtitle: user_getxController.user_model.displayName,),
                  Padding(padding: EdgeInsets.only(left: 5.h),child: Text("This is not your username or pin. This name will be visible to your Whatsapp contact.",style: TextStyle(fontSize: 1.4.h,color: Colors.grey),)),
                  SizedBox(
                    height: 2.h,
                  ),
                  listTile(leading: Icons.info_outline, title: "About", subtitle: user_getxController.user_model.about, onPressed: null),
                  SizedBox(
                    height: 2.h,
                  ),
                  listTile(leading: Icons.call, title: "Phone", subtitle: user_getxController.user_model.phoneNumber, onPressed: null),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
  Widget listTile({
  required IconData leading,
  required String title,
  required String subtitle,
  required onPressed,
}){
    return  ListTile(
      leading: Icon(leading),
      title: Text(title,style: TextStyle(color: Colors.grey)),
      subtitle: Text(subtitle),
      trailing: IconButton(onPressed: onPressed, icon: Icon(Icons.edit)),
    );
  }
}
