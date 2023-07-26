import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/controllers/log_in_out_gc.dart';
import 'package:firebase_chat_app/helper/cloud_firestore_helper.dart';
import 'package:firebase_chat_app/helper/fcm_messaging_helper.dart';
import 'package:firebase_chat_app/helper/firebase_auth_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Google_login_out_GetController google_login_out_getController =
  Get.put(Google_login_out_GetController());
  int index = 0;
  GlobalKey<FormState> globalKeySignUp = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeySignIn = GlobalKey<FormState>();
  TextEditingController nameSingUpController = TextEditingController();
  TextEditingController nameSingInController = TextEditingController();
  TextEditingController phoneNumberSingUpController = TextEditingController();
  TextEditingController phoneNumberSingInController = TextEditingController();
  TextEditingController emailSingUpController = TextEditingController();
  TextEditingController emailSingInController = TextEditingController();
  TextEditingController passwordSingUpController = TextEditingController();
  TextEditingController passwordSingInController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: index == 0
                    ? AssetImage("assets/images/login.png")
                    : AssetImage("assets/images/sign_up.png"),
                fit: BoxFit.cover),
          ),
          alignment: Alignment.center,
          child: IndexedStack(
            index: index,
            children: [
              //singIn
              Column(
                children: [
                  Spacer(
                    flex: 5,
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        LinearGradient(
                          colors: [Colors.black, Colors.blue],
                        ).createShader(bounds),
                    child: Text(
                      'ChatApp',
                      style: TextStyle(
                        fontSize: 10.w,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    "Log In",
                    style: TextStyle(
                        fontSize: 8.w, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    child: Form(
                      key: globalKeySignIn,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Full Name",
                                style: TextStyle(
                                  fontSize: 4.w,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextFormField(
                                controller: nameSingInController,
                                decoration: InputDecoration(
                                  hintText: "Enter your full name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                validator: (val) {
                                  return (val!.isEmpty)
                                      ? "Enter fullname first..."
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email address",
                                style: TextStyle(
                                  fontSize: 4.w,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextFormField(
                                controller: emailSingInController,
                                decoration: InputDecoration(
                                  hintText: "Enter your email address",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                validator: (val) {
                                  return (val!.isEmpty)
                                      ? "Enter email first..."
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 4.w,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextFormField(
                                controller: passwordSingInController,
                                decoration: InputDecoration(
                                  hintText: "Enter a password",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                validator: (val) {
                                  return (val!.isEmpty)
                                      ? "Enter password first..."
                                      : null;
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("forgot password?"),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "new user? ",
                                        style: TextStyle(color: Colors.black)),
                                    TextSpan(
                                        text: " Sign-Up",
                                        style: TextStyle(color: Colors.indigo),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            setState(() {
                                              index = 1;
                                              nameSingUpController.clear();
                                              phoneNumberSingUpController
                                                  .clear();
                                              emailSingInController.clear();
                                              passwordSingInController.clear();
                                            });
                                          }),
                                  ]),
                                )

                              ]),
                          SizedBox(
                            height: 6.h,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(
                                Size(45.w, 6.h),
                              ),
                            ),
                            onPressed: () async {
                              await validateAndSignIn();
                              emailSingInController.clear();
                              passwordSingInController.clear();
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("----------------------------------"),
                        Text("or"),
                        Text("----------------------------------"),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      multiFactorAuth(
                        onTap: () async {
                          Map<String, dynamic> data =
                          await FBHelper.fbHelper.singInWithGoogle();

                          if (data['user'] != null) {
                            Get.snackbar(
                              "Success",
                              "Sing in Successfull...",
                              backgroundColor: Colors.green,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 1),
                            );
                            if (await CFSHelper.cfsHelper.userExits()) {
                              CFSHelper.cfsHelper.diplayAllRecode();
                              Get.offAndToNamed('/');
                            } else {
                              CFSHelper.cfsHelper
                                  .createUser()
                                  .then((value) => Get.offAndToNamed('/'));
                            }
                            google_login_out_getController.trueValue();
                          } else {
                            Get.snackbar(
                              "Failed",
                              data['msg'],
                              backgroundColor: Colors.redAccent,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 1),
                            );
                          }
                        },
                        image: "assets/images/google.png",
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      multiFactorAuth(
                        onTap: () {},
                        image: "assets/images/facebook.png",
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      multiFactorAuth(
                        onTap: () {},
                        image: "assets/images/twitter.png",
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
              //singUp
              Column(
                children: [
                  Spacer(
                    flex: 5,
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        LinearGradient(
                          colors: [Colors.black, Colors.blue],
                        ).createShader(bounds),
                    child: Text(
                      'ChatApp',
                      style: TextStyle(
                        fontSize: 10.w,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 8.w, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    child: Form(
                      key: globalKeySignUp,
                      child: Column(
                        children: [
                          column(
                            context: " Your Name",
                            hintText: "Enter your Full name",
                            controller: nameSingUpController,
                            validator: (val) {
                              return (val!.isEmpty)
                                  ? "Enter Full Name First..."
                                  : null;
                            },
                          ),
                          column(
                            context: " Phone number",
                            hintText: "Enter your phone number",
                            controller: phoneNumberSingUpController,
                            validator: (val) {
                              return (val!.isEmpty)
                                  ? "Enter phone number First..."
                                  : null;
                            },
                          ),
                          column(
                            context: " Email address",
                            hintText: "Enter your email address",
                            controller: emailSingUpController,
                            validator: (val) {
                              return (val!.isEmpty)
                                  ? "Enter email address First..."
                                  : null;
                            },
                          ),
                          column(
                            context: " Password",
                            hintText: "Enter a password",
                            controller: passwordSingUpController,
                            validator: (val) {
                              return (val!.isEmpty)
                                  ? "Enter Password First..."
                                  : null;
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(
                                Size(45.w, 6.h),
                              ),
                            ),
                            onPressed: () async {
                              await validateAndSignUp();
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "You have already Account? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: " Sign-In",
                            style: TextStyle(color: Colors.indigo),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  index = 0;
                                  nameSingUpController.clear();
                                  phoneNumberSingUpController.clear();
                                  emailSingUpController.clear();
                                  passwordSingUpController.clear();
                                });
                              }),
                      ]),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("----------------------------------"),
                        Text("or"),
                        Text("----------------------------------"),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      multiFactorAuth(
                        onTap: () async {
                          Map<String, dynamic> data =
                          await FBHelper.fbHelper.singInWithGoogle();

                          if (data['user'] != null) {
                            Get.snackbar(
                              "Success",
                              "Sing in Successfull...",
                              backgroundColor: Colors.green,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 1),
                            );
                            if (await CFSHelper.cfsHelper.userExits()) {
                              CFSHelper.cfsHelper.diplayAllRecode();
                              Get.offAndToNamed('/');
                            } else {
                              CFSHelper.cfsHelper
                                  .createUser()
                                  .then((value) => Get.offAndToNamed('/'));
                            }
                            google_login_out_getController.trueValue();
                          } else {
                            Get.snackbar(
                              "Failed",
                              data['msg'],
                              backgroundColor: Colors.redAccent,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 1),
                            );
                          }
                        },
                        image: "assets/images/google.png",
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      multiFactorAuth(
                        onTap: () {},
                        image: "assets/images/facebook.png",
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      multiFactorAuth(
                        onTap: () {},
                        image: "assets/images/twitter.png",
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget column({
    required String context,
    required String hintText,
    required TextEditingController controller,
    required validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context,
          style: TextStyle(
            fontSize: 4.w,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          validator: validator,
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }

  Widget multiFactorAuth({
    required onTap,
    required String image,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundImage: AssetImage(image),
      ),
    );
  }
  Future<void> validateAndSignIn() async {
    if (globalKeySignIn.currentState!.validate()) {
      globalKeySignIn.currentState!.save();
      String? userMessagingTokan = await FCMHelper.fcmHelper.fetchTokan();

      Map<String, dynamic> data = await FBHelper.fbHelper
          .signInWithEmailPassword(
          email: emailSingInController.text,
          password: passwordSingInController.text,
      );

      if (data['user'] != null) {
        Get.snackbar(
          "Success",
          "Sing in Successfull...",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );
        Get.offAndToNamed('/');
        google_login_out_getController.trueValue();
      } else {
        Get.snackbar(
          "Failed",
          data['msg'],
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );
      }
    }
  }

  Future<void> validateAndSignUp() async {
    if (globalKeySignUp.currentState!.validate()) {
      globalKeySignUp.currentState!.save();

      Map<String, dynamic> data = await FBHelper.fbHelper
          .signUpWithEmailPassword(
          email: emailSingUpController.text,
          password: passwordSingUpController.text);

      if (data['user'] != null) {
        Get.snackbar(
          "Success",
          "Sing in Successfull...",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );
        User? user = data['user'];
        if (await CFSHelper.cfsHelper.userExits()) {
          print("1");
          CFSHelper.cfsHelper.diplayAllRecode();
          setState(() {
            index = 0;
          });
        } else {
          print("2");
          CFSHelper.cfsHelper
              .createUser(name: nameSingUpController.text,phoneNumber: phoneNumberSingUpController.text)
              .then((value) =>   setState(() {
            index = 0;
          }));
        }

      } else {
        Get.snackbar(
          "Failed",
          data['msg'],
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );
      }
    }
  }
}
