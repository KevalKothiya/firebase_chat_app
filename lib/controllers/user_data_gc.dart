import 'package:firebase_chat_app/modals/global/user_data.dart';
import 'package:firebase_chat_app/modals/util/utils.dart';
import 'package:get/get.dart';

class User_GetxController extends GetxController {
  User_Model user_model = User_Model(
    email: box.read('email') ?? "",
    uid: box.read('uid') ?? "",
    displayName: box.read('displayName') ?? "",
    phoneNumber: box.read('phoneNumber') ?? "",
    about: box.read('about') ?? "",
    photoURl: box.read('photoURl') ?? "",
    token: box.read('token') ?? "",
  );

  initialization({
    required String email,
    required String uid,
    required String displayName,
     String? phoneNumber,
     String? photoURl,
     String? about,
    required String token,
  }) {
    user_model.email = email;
    user_model.uid = uid;
    user_model.displayName = displayName;
    user_model.phoneNumber = phoneNumber ?? "+91 9876543210";
    user_model.about = about ?? "Hey!";
    user_model.photoURl = photoURl ?? "";
    user_model.token = token;

    box.write('email', user_model.email);
    box.write('uid', user_model.uid);
    box.write('displayName', user_model.displayName);
    box.write('phoneNumber', user_model.phoneNumber);
    box.write('about', user_model.about);
    box.write('photoURl', user_model.photoURl);
    box.write('token', user_model.token);

    update();
  }


  updateValue({required String val}){
    user_model.displayName = val;
    box.write('displayName', user_model.displayName);
    update();
  }
}
