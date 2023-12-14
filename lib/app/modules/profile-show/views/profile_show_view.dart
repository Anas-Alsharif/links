import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:links/app/core/colors.dart';

import '../controllers/profile_show_controller.dart';

class ProfileShowView extends GetView<ProfileShowController> {
  const ProfileShowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileShowController());
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: Text('User Info'.tr),
            centerTitle: true,
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
                      children: [
                        
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.greyColor, width: 3)),
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(controller.user["image"],
                                  width: 100, height: 100, fit: BoxFit.cover)),
                        ),
                        const Divider(height: 50),
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
                      ],
                    ),
                  ),
                ));
    });
  }
}
