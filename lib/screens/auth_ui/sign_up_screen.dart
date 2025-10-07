import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:shop_app27/controllers/sign_up_controller.dart';
import 'package:shop_app27/screens/auth_ui/sign_in_screen.dart';
import 'package:shop_app27/services/notification_service.dart';

import '../../utils/app_constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
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
                  SizedBox(height: Get.height / 20),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "WelCome to my app",
                      style: TextStyle(
                        color: AppConstant.appScendoryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
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
                      child: TextFormField(
                        controller: userName,
                        cursorColor: AppConstant.appScendoryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "UserName",
                          prefixIcon: Icon(Icons.person),
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
                      child: TextFormField(
                        controller: userPhone,
                        cursorColor: AppConstant.appScendoryColor,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "Phone",
                          prefixIcon: Icon(Icons.phone),
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
                      child: TextFormField(
                        controller: userCity,
                        cursorColor: AppConstant.appScendoryColor,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "City",
                          prefixIcon: Icon(Icons.location_pin),
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
                          obscureText: signUpController.isPasswordVisible.value,
                          cursorColor: AppConstant.appScendoryColor,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),

                            suffixIcon: GestureDetector(
                              onTap: () {
                                signUpController.isPasswordVisible.toggle();
                              },
                              child: signUpController.isPasswordVisible.value
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
                          NotificationService notificationService =
                              NotificationService();
                          String name = userName.text.trim();
                          String email = userEmail.text.trim();
                          String phone = userPhone.text.trim();
                          String city = userCity.text.trim();
                          String password = userPassword.text.trim();
                          String userDeviceToken = await notificationService
                              .getDeviceToken();

                          if (name.isEmpty ||
                              email.isEmpty ||
                              phone.isEmpty ||
                              city.isEmpty ||
                              password.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Pleased enter all details",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          } else {
                            UserCredential? userCredential =
                                await signUpController.signUpMethod(
                                  name,
                                  email,
                                  phone,
                                  city,
                                  password,
                                  userDeviceToken,
                                );
                            if (userCredential != null) {
                              Get.snackbar(
                                "Verification email sent",
                                "Pleased check your email",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appScendoryColor,
                                colorText: AppConstant.appTextColor,
                              );
                              FirebaseAuth.instance.signOut();

                              Get.offAll(() => SignInScreen());
                            }
                          }
                        },
                        child: Text(
                          "SIGN Up",
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
                        "Already  have an account? ",
                        style: TextStyle(color: AppConstant.appScendoryColor),
                      ),
                      GestureDetector(
                        onTap: () => Get.offAll(() => SignInScreen()),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: AppConstant.appScendoryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
