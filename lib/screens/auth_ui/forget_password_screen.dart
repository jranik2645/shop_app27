import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app27/screens/auth_ui/sign_up_screen.dart';
import 'package:shop_app27/utils/app_constant.dart';
import '../../controllers/forget_password_controller.dart';

class ForgetPassWordScreen extends StatefulWidget {
  const ForgetPassWordScreen({super.key});

  @override
  State<ForgetPassWordScreen> createState() => _ForgetPassWordScreenState();
}

class _ForgetPassWordScreenState extends State<ForgetPassWordScreen> {
  final ForgetPasswordController forgetPasswordController = Get.put(
    ForgetPasswordController(),
  );

  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appScendoryColor,
            title: Text(
              "Forget Password",
              style: TextStyle(color: AppConstant.appTextColor),
            ),
            centerTitle: true,
          ),
          body: Container(
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

                        if (email.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please enter all details",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appScendoryColor,
                            colorText: AppConstant.appTextColor,
                          );
                        } else {
                          String email = userEmail.text.trim();
                          forgetPasswordController.ForgetPasswordMethod(email);
                        }
                      },
                      child: Text(
                        "Forget ",
                        style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
