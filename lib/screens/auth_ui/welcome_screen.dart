import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app27/utils/app_constant.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appScendoryColor,
        title: Text(
          "Welcome to my app",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(child: Lottie.asset("assets/images/splash-icon.json"),

            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Happy Shopping",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: Get.height / 12),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Image.asset("assets/images/google.png",height: 50,width: 50,),

                  label: Text("Sign in with google"
                    ,style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
            ),

            SizedBox(height: Get.height / 30),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Image.asset("assets/images/email.png",height: 50,width: 50,),
                  label: Text("Sign in with email",
                    style: TextStyle(
                    color: AppConstant.appTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),),
                  ),
                ),
              ),
            SizedBox(height: Get.height / 30),
            Material(
              child: Container(
                width: Get.width / 1.2,
                height: Get.height / 12,
                decoration: BoxDecoration(
                  color: AppConstant.appScendoryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Image.asset("assets/images/phone-call.png",height: 50,width: 50,),
                  label: Text("Sign in with phone",
                    style: TextStyle(
                      color: AppConstant.appTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
