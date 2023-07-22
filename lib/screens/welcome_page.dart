import 'package:firebase_chat_app/controllers/Welcome_page_gc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:dots_indicator/dots_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Welcome_GetxController welcomeController = Get.put(Welcome_GetxController());

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
      keepPage: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Welcome_GetxController>(
        builder: (context) {
          return SizedBox(
            width: 100.w,
            height: 100.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  physics: ClampingScrollPhysics(),
                  onPageChanged: (val) {
                    welcomeController.initializedValue(index: val);
                  },
                  children: [
                    container(
                      images: "assets/images/attachment1.jpg",
                      context1: "Send Free Message",
                      context2:
                          "Cras dapibus. Vivamus elementum semper nisi.\n",
                      context3:
                          "Aenean vulputate eleifend tellus. Aenean leo\n",
                      context4: "ligula, porttitor, eu consequat vitae.\n",
                    ),
                    container(
                      images: "assets/images/attachment3.jpg",
                      context1: "Connect Your Friend",
                      context2:
                          "Cras dapibus. Vivamus elementum semper nisi.\n",
                      context3:
                          "Aenean vulputate eleifend tellus. Aenean leo\n",
                      context4: "ligula, porttitor, eu consequat vitae.\n",
                    ),
                    container(
                        images: "assets/images/attachment2.jpg",
                        context1: "Make Group Chat",
                        context2:
                            "Cras dapibus. Vivamus elementum semper nisi.\n",
                        context3:
                            "Aenean vulputate eleifend tellus. Aenean leo\n",
                        context4: "ligula, porttitor, eu consequat vitae.\n",
                        buttonEnabled: true),
                  ],
                ),
                Positioned(
                  bottom: 9.h,
                  child: DotsIndicator(
                    dotsCount: 3,
                    reversed: false,
                    mainAxisAlignment: MainAxisAlignment.center,
                    position: welcomeController.welconeModel.index,
                    decorator: DotsDecorator(
                      size: Size.square(2.2.w),
                      activeSize: Size(6.w, 1.2.h),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.2.w),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TextStyle style() {
    return TextStyle(
      color: Colors.grey,
      fontSize: 4.w,
      fontWeight: FontWeight.normal,
    );
  }

  Widget container({
    required String images,
    required String context1,
    required String context2,
    required String context3,
    required String context4,
    bool buttonEnabled = false,
  }) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff393a54),
            Color(0xff1a1929),
          ],
        ),
        image: DecorationImage(
          image: AssetImage(images),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 35.h,
            child: Text(
              context1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 5.w,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Positioned(
            bottom: 23.h,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: context2,
                    style: style(),
                  ),
                  TextSpan(
                    text: context3,
                    style: style(),
                  ),
                  TextSpan(
                    text: context4,
                    style: style(),
                  ),
                ],
              ),
            ),
          ),
          buttonEnabled == false
              ? Container()
              : Positioned(
                  bottom: 12.h,
                  child: ElevatedButton(
                    onPressed: () {
                      welcomeController.initializedTrueForWelcome(val: true);
                      Get.offAllNamed('/login_page');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.5.w),
                        ),
                      ),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Text("Login"),
                  ),
                ),
        ],
      ),
    );
  }
}
