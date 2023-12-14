import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/alert.dart';
import '../../../core/colors.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  TextEditingController forgotPasswordEmail = TextEditingController();
  RxBool obscureText = true.obs;
  RxBool loading = false.obs;
  RxBool loadingForgotPassword = false.obs;

  loginUser() async {
    if (email.text.trim().isEmpty) {
      return Get.showSnackbar(
          Ui.DefaultSnackBar(message: "Please enter the email".tr));
    }
    if (password.text.trim().isEmpty) {
      return Get.showSnackbar(
          Ui.DefaultSnackBar(message: "Please enter the password".tr));
    }
    try {
      loading.value = true;
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      GetStorage().write("id", user.user!.uid);
      Get.offAllNamed(Routes.MAIN_SCREEN);
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      if (e.code == "wrong-password") {
        return Get.showSnackbar(Ui.ErrorSnackBar(
            message: "Email address or password was wrong".tr));
      }
      if (e.code == 'invalid-email') {
        return Get.showSnackbar(
            Ui.ErrorSnackBar(message: "Email address invalid".tr));
      }
      if (e.code == 'too-many-requests') {
        return Get.showSnackbar(
            Ui.ErrorSnackBar(message: "Too many requests, try again later".tr));
      }
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.code));
    }
  }

  sendForgotPasswordEmail() async {
    if (forgotPasswordEmail.text.trim().isEmpty) {
      return Get.showSnackbar(
          Ui.DefaultSnackBar(message: "Please enter the email".tr));
    }
    try {
      loadingForgotPassword.value = true;
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgotPasswordEmail.text);
      loadingForgotPassword.value = false;
      Get.back();
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "Reset password link has been sent to your email".tr));
    } on FirebaseAuthException catch (e) {
      loadingForgotPassword.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.code.toString()));
    }
  }

  forgotPassword() => Get.bottomSheet(Obx(() {
        return Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 7,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              const SizedBox(height: 30),
              Text("Email".tr, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: forgotPasswordEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: const Icon(FontAwesomeIcons.solidEnvelope),
                    hintText: "Enter your email".tr),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.primaryColor),
                        onPressed: () => loadingForgotPassword.value
                            ? null
                            : sendForgotPasswordEmail(),
                        child: loadingForgotPassword.value
                            ? const SpinKitThreeBounce(
                                color: Colors.white, size: 20)
                            : Text(
                                "Confirm".tr,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(.2)),
                        onPressed: () => Get.back(),
                        child: Text(
                          "Cancel".tr,
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 20),
                        )),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
          backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
          isScrollControlled: true);
}
