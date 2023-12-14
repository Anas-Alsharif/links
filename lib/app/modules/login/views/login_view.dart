import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/colors.dart';
import '../../../core/images.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.updateLocale(
                      Locale(Get.locale.toString() != "ar" ? 'ar' : 'en'));
                  GetStorage().write('lang', Get.locale.toString());
                },
                child: Center(
                  child: Text(
                      Get.locale.toString() != "ar" ? "عربي" : "English",
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 17),
              GestureDetector(
                onTap: () {
                  Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                  GetStorage().write("isDarkMode", !Get.isDarkMode);
                },
                child: SvgPicture.asset(AppImages.themeMode,
                    width: 20, color: AppColors.primaryColor),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      blurRadius: 10,
                      spreadRadius: 10)
                ], borderRadius: BorderRadius.circular(500)),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(AppImages.logo),
                ),
              ),
              const Divider(height: 100).marginSymmetric(horizontal: 50),
              TextField(
                controller: controller.email,
                decoration: InputDecoration(
                  hintText: 'Email'.tr,
                  prefixIcon: const Icon(FontAwesomeIcons.solidEnvelope),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(() {
                return TextField(
                  controller: controller.password,
                  obscureText: controller.obscureText.value,
                  decoration: InputDecoration(
                    hintText: 'Password'.tr,
                    prefixIcon: const Icon(FontAwesomeIcons.lock),
                    suffixIcon: IconButton(
                        onPressed: () => controller.obscureText.value =
                            !controller.obscureText.value,
                        icon: Icon(!controller.obscureText.value
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash)),
                  ),
                );
              }),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => controller.forgotPassword(),
                child: Text(
                  'Forgot your password?'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Obx(() {
                    return TextButton(
                        onPressed: () => controller.loading.value
                            ? null
                            : controller.loginUser(),
                        child: controller.loading.value
                            ? const SpinKitThreeBounce(
                                color: Colors.white, size: 20)
                            : Text("LOGIN".tr));
                  })),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? '.tr,
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.SIGNUP),
                    child: Text(
                      'Register'.tr,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
