import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/controllers/user_data_gc.dart';
import 'package:firebase_chat_app/helper/cloud_firestore_helper.dart';
import 'package:firebase_chat_app/helper/fcm_messaging_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FBHelper {
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
      user_getxController.initialization(
          email: firebaseAuth.currentUser!.email!,
          uid: firebaseAuth.currentUser!.uid,
          displayName: firebaseAuth.currentUser!.displayName!,
          photoURl: firebaseAuth.currentUser!.photoURL!,
          token: userToken!);

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

  Future<Map<String, dynamic>> signInWithEmailPassword(
      {required String email, required String password}) async {
    Map<String, dynamic> data = {};

    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      data['user'] = user;

      // User_GetxController userController = User_GetxController();
      // String? userToken = await FCMHelper.fcmHelper.fetchTokan();
      // Stream<QuerySnapshot> userData = CFSHelper.cfsHelper.diplayCurrentUser();
      //
      // userController.initialization(
      //     email: firebaseAuth.currentUser!.email!,
      //     uid: firebaseAuth.currentUser!.uid,
      //     displayName: firebaseAuth.currentUser!.displayName!,
      //     token: userToken!);

      return data;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'admin-restricted-operation':
          data['msg'] = "This service is temporary dowm.";

        case 'wrong-password':
          data['msg'] = "Wrong Password.";

        case 'user-not-found':
          data['msg'] = "This user is not created yet.";

        case 'user-disabled':
          data['msg'] = "User is disabled, contact admin.";
        default:
          data['msg'] = e.code;
      }
      return data;
    }
  }

  Future<Map<String, dynamic>> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> data = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      data['user'] = user;
      return data;
    } on FirebaseAuthException catch (e) {
      switch (e) {
        case 'weak-password':
          data['msg'] = "Password at least 6 char long.";
        case 'email-already-in-use':
          data['msg'] = "This user is already exists.";
        case 'email-already-in-use':
          data['msg'] = "This user is already exists.";
        default:
          data['msg'] = e.code;
      }
      return data;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
