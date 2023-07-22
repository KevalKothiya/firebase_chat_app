import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/controllers/drawer_gc.dart';
import 'package:firebase_chat_app/controllers/log_in_out_gc.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
import 'package:firebase_chat_app/helper/cloud_firestore_helper.dart';
import 'package:firebase_chat_app/helper/firebase_auth_helper.dart';
import 'package:firebase_chat_app/modals/global/chat_user.dart';
import 'package:firebase_chat_app/modals/global/drawer_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
class MenuItems {
  static const profile = MenuItem('My profile', Icons.person_pin);
  static const account = MenuItem('Account', Icons.key);
  static const privacy = MenuItem('Privacy', CupertinoIcons.lock_circle);
  static const chat = MenuItem('Chats', CupertinoIcons.chat_bubble_2_fill);
  static const setting = MenuItem('Setting', Icons.people_alt_outlined);
  static const support = MenuItem('Support', CupertinoIcons.phone);
  static const logout = MenuItem('Logout', Icons.logout);

  static const all = <MenuItem>[
    profile,
    account,
    privacy,
    chat,
    setting,
    support,
    logout,
  ];
}
class MenuScreen extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuScreen({Key? key, required this.currentItem, required this.onSelectedItem}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Container(
          child:Column(
            children: [
              Spacer(),
              ...MenuItems.all.map(buildMenuItem).toList(),
              Spacer(flex: 2,)
            ],
          ),
        ),
      ),
    );
  }
  Widget buildMenuItem(MenuItem item) => ListTileTheme(
    selectedColor: Colors.white,
    child: ListTile(
      selectedTileColor: Colors.black26,
      selected: currentItem == item,
      minLeadingWidth: 20,
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: () => onSelectedItem(item),
    ),
  );
}
class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => ZoomDrawer.of(context)!.toggle(),
        icon: Icon(Icons.menu));
  }
}


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PayMent Page"),
        leading: MenuWidget(),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuItem currentItem = MenuItems.profile;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 40,
      showShadow: true,

      
      mainScreen: MainScreen(),
      menuScreen: Builder(
        builder: (context) {
          return MenuScreen(
            currentItem : currentItem,
            onSelectedItem : (item){
              setState(() {
                currentItem = item;
                ZoomDrawer.of(context)!.close();
                // Get.back();
                // Get.toNamed('/profile_page');
              });
            },
          );
        }
      ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Drawer_GetxController drawerController = Get.put(Drawer_GetxController());
//
//   User_GetxController user_getxController = Get.put(User_GetxController());
//   Google_login_out_GetController google_login_out_getController =
//       Get.put(Google_login_out_GetController());
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   loadData() async {
//     CFSHelper.cfsHelper.diplayCurrentUser();
//     CFSHelper.cfsHelper.diplayAllRecode();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: ZoomDrawer(
//         controller: drawerController.zoomDrawerController,
//         menuScreen: HomePage(),
//         mainScreen: MenuScreen(),
//         style: DrawerStyle.defaultStyle,
//         borderRadius: 24,
//         showShadow: true,
//         angle: -12.0,
//         drawerShadowsBackgroundColor: Colors.grey.shade300,
//         slideWidth: MediaQuery.of(context).size.width*.65,
//         openCurve: Curves.fastOutSlowIn,
//         closeCurve: Curves.bounceIn,
//       ),
//       // drawer: Drawer(
//       //   child: Column(
//       //     children: [
//       //       SizedBox(
//       //         height: 5.h,
//       //       ),
//       //       CircleAvatar(
//       //         radius: 7.h,
//       //         foregroundImage:
//       //             NetworkImage("${user_getxController.user_model.photoURl}"),
//       //       ),
//       //       SizedBox(
//       //         height: 2.h,
//       //       ),
//       //       Text(user_getxController.user_model.email),
//       //       Text(user_getxController.user_model.displayName),
//       //       Text(user_getxController.user_model.uid),
//       //       (user_getxController.user_model.phoneNumber == "")
//       //           ? Text("PhoneNumber : Khali")
//       //           : Text(user_getxController.user_model.phoneNumber),
//       //       Text(user_getxController.user_model.token),
//       //     ],
//       //   ),
//       // ),
//       appBar: AppBar(
//         title: Text("Project Started"),
//         leading: MenuScreen(),
//         actions: [
//           IconButton(
//               onPressed: () async {
//                 await FBHelper.fbHelper.signOut();
//                 google_login_out_getController.falseValue();
//                 Get.offAllNamed("/login_page");
//               },
//               icon: Icon(Icons.logout))
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.all(1.2.h),
//         child: StreamBuilder(
//             stream: CFSHelper.cfsHelper.diplayAllRecode(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text("Error :${snapshot.error}"),
//                 );
//               } else if (snapshot.hasData) {
//                 QuerySnapshot<Map<String, dynamic>> ss =
//                     snapshot.data as QuerySnapshot<Map<String, dynamic>>;
//
//                 List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
//                     ss.docs;
//
//                 return (data.isEmpty)
//                     ? const Center(
//                         child: Text("Empty"),
//                       )
//                     : ListView.builder(
//                         itemCount: data.length,
//                         itemBuilder: (context, i) {
//                           return Card(
//                             child: ListTile(
//                               onTap: () {
//                                 Get.toNamed('/chat_page', arguments: data[i]);
//                               },
//                               leading: CachedNetworkImage(
//                                 imageUrl: data[i].data()['image'],
//                                 imageBuilder: (context, imageProvider) =>
//                                     CircleAvatar(
//                                   foregroundImage:
//                                       NetworkImage(data[i].data()['image']),
//                                 ),
//                                 placeholder: (context, url) =>
//                                     CircularProgressIndicator(),
//                                 errorWidget: (context, url, error) =>
//                                     Icon(Icons.error),
//                               ),
//                               title: Text(data[i].data()['name']),
//                               subtitle: Text(data[i].data()['id']),
//                               isThreeLine: true,
//                             ),
//                           );
//                         });
//               }
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }),
//       ),
//     );
//   }
// }
