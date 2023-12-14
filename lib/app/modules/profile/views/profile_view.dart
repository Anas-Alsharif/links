import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:links/app/routes/app_pages.dart';

import '../../../core/colors.dart';
import '../../../core/images.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: Text('User Info'.tr),
            centerTitle: true,
            leadingWidth: 100,
            leading: GestureDetector(
              onTap: () {
                Get.updateLocale(
                    Locale(Get.locale.toString() != "ar" ? 'ar' : 'en'));
                GetStorage().write('lang', Get.locale.toString());
              },
              child: Center(
                child: Text(Get.locale.toString() != "ar" ? "عربي" : "English",
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
            ),
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
          body: controller.user.isEmpty
              ? Center(
                  child: SpinKitThreeBounce(color: AppColors.primaryColor),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.greyColor, width: 3)),
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(controller.user["image"],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const Divider(height: 50),
                        Row(
                          children: [
                            Text("User Info".tr,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            const Icon(FontAwesomeIcons.edit, size: 15),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () => Get.toNamed(Routes.PROFILE_EDIT, arguments: {"user" : controller.user}),
                              child: Text("Edit Profile".tr)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.greyColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.solidEnvelope),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Email".tr),
                                      const SizedBox(height: 5),
                                      Text(controller.user["name"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(height: 30),
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.solidCircleUser),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Username".tr),
                                      const SizedBox(height: 5),
                                      Text(controller.user["email"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.red[900]),
                                onPressed: () {
                                  GetStorage().erase();
                                  Get.offAllNamed(Routes.LOGIN);
                                },
                                child: Text("Sign Out".tr)))
                      ],
                    ),
                  ),
                ));
    });
  }
}
