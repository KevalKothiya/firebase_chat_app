import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
import 'package:firebase_chat_app/helper/fcm_messaging_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FBHelper{
  FBHelper._();

  static final FBHelper fbHelper = FBHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Map<String, dynamic>> singInWithGoogle() async {
    Map<String, dynamic> data = {};

    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
      await firebaseAuth.signInWithCredential(credential);

      User_GetxController user_getxController = User_GetxController();
      String? userToken = await FCMHelper.fcmHelper.fetchTokan();
      user_getxController.initialization(email: firebaseAuth.currentUser!.email!, uid: firebaseAuth.currentUser!.uid, displayName: firebaseAuth.currentUser!.displayName!, photoURl: firebaseAuth.currentUser!.photoURL!, token: userToken!);

      User? user = userCredential.user;

      data['user'] = user;
      return data;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          data['msg'] = "This service is temporary dowm.";

        default:
          data['msg'] = e.code;
      }
      return data;
    }
  }


  Future<void> signOut() async{
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}