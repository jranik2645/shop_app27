import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_app27/screens/auth_ui/sign_in_screen.dart';
import '../utils/app_constant.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> ForgetPasswordMethod(String userEmail) async {
    try {
      EasyLoading.show(status: 'Please Wait');
      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
        'Request Sent Successfully',
        "Password rest link sent to $userEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
      Get.offAll(() => SignInScreen());
      EasyLoading.dismiss();
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        'Error',
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}
