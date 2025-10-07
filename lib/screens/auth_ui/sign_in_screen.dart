import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app27/controllers/sign_in_controller.dart';
import 'package:shop_app27/screens/auth_ui/forget_password_screen.dart';
import 'package:shop_app27/screens/auth_ui/sign_up_screen.dart';
import 'package:shop_app27/screens/user_panel/main_screen.dart';
import 'package:shop_app27/utils/app_constant.dart';

import '../../controllers/get_user_data_controller.dart';
import '../admin_panel/admin_Main_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController = Get.put(
    GetUserDataController(),
  );

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appScendoryColor,
            title: Text(
              "Sign In",
              style: TextStyle(color: AppConstant.appTextColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  isKeyboardVisible
                      ? Text('Welcome to my app')
                      : Column(
                          children: [
                            Lottie.asset("assets/images/splash-icon.json"),
                          ],
                        ),
                  SizedBox(height: Get.height / 20),
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: userEmail,
                        cursorColor: AppConstant.appScendoryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: Get.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => TextFormField(
                          controller: userPassword,
                          obscureText: signInController.isPasswordVisible.value,
                          cursorColor: AppConstant.appScendoryColor,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signInController.isPasswordVisible.toggle();
                              },
                              child: signInController.isPasswordVisible.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                            contentPadding: EdgeInsets.only(
                              top: 2.0,
                              left: 8.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ForgetPassWordScreen());
                      },

                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: AppConstant.appScendoryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width / 20),
                  Material(
                    child: Container(
                      width: Get.width / 2,
                      height: Get.height / 18,
                      decoration: BoxDecoration(
                        color: AppConstant.appScendoryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          String email = userEmail.text.trim();
                          String password = userPassword.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar("Error", "Please enter all details");
                          } else {
                            UserCredential? userCredential =
                                await signInController.singInMethod(
                                  email,
                                  password,
                                );

                            var userData = await getUserDataController
                                .getUserData(userCredential!.user!.uid);

                            if (userCredential != null) {
                              if (userCredential.user!.emailVerified) {
                                ///admin
                                if (userData[0]['isAdmin'] == true) {
                                  Get.snackbar(
                                    "Success Admin Login",
                                    "login Successfully",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        AppConstant.appScendoryColor,
                                    colorText: AppConstant.appTextColor,
                                  );
                                  Get.offAll(() => AdminMainScreen());
                                } else {
                                  Get.offAll(() => MainScreen());
                                  Get.snackbar(
                                    "Success User Login",
                                    "login Successfully",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        AppConstant.appScendoryColor,
                                    colorText: AppConstant.appTextColor,
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Please verify your email before login",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appScendoryColor,
                                  colorText: AppConstant.appTextColor,
                                );
                              }
                            } else {
                              Get.snackbar(
                                "Error",
                                "Please try again",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appScendoryColor,
                                colorText: AppConstant.appTextColor,
                              );
                            }
                          }
                        },
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: AppConstant.appTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: AppConstant.appScendoryColor),
                      ),
                      GestureDetector(
                        onTap: () => Get.offAll(() => SignUpScreen()),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: AppConstant.appScendoryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
