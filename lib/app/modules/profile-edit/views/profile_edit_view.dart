import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import '../../../core/colors.dart';
import '../../../core/images.dart';
import '../../../core/upload_image.dart';
import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            blurRadius: 10,
                            spreadRadius: 10)
                      ], borderRadius: BorderRadius.circular(500)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: controller.image.value == null
                            ? Image.network(
                                AppImages.logo,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                controller.image.value!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.4),
                        borderRadius: BorderRadius.circular(500)),
                    child: PullDownButton(
                      itemBuilder: (context) => [
                        PullDownMenuItem(
                          title: 'Camera'.tr,
                          icon: FontAwesomeIcons.camera,
                          iconColor: AppColors.primaryColor,
                          itemTheme: PullDownMenuItemTheme(
                              textStyle: Get.textTheme.titleMedium),
                          onTap: () =>
                              UploadImage().imgFromCamera(controller.image),
                        ),
                        // const PullDownMenuDivider(),
                        PullDownMenuItem(
                          title: 'Image Gallery'.tr,
                          icon: FontAwesomeIcons.image,
                          iconColor: AppColors.primaryColor,
                          itemTheme: PullDownMenuItemTheme(
                              textStyle: Get.textTheme.titleMedium),
                          onTap: () =>
                              UploadImage().imgFromGallery(controller.image),
                        ),
                      ],
                      position: PullDownMenuPosition.over,
                      buttonBuilder: (context, showMenu) => CupertinoButton(
                        onPressed: showMenu,
                        padding: EdgeInsets.zero,
                        child:
                            const Icon(Icons.add_a_photo, color: Colors.white),
                      ),
                    ),
                  )
                ],
              );
            }),
            const Divider(height: 100).marginSymmetric(horizontal: 50),
            Text("Username".tr),
            SizedBox(height: 10),
            TextField(
              controller: controller.username,
              decoration: InputDecoration(
                hintText: 'Username'.tr,
                prefixIcon: const Icon(FontAwesomeIcons.solidCircleUser),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text("Email".tr),
            SizedBox(height: 10),
            TextField(
              controller: controller.email,
              decoration: InputDecoration(
                hintText: 'Email'.tr,
                prefixIcon: const Icon(FontAwesomeIcons.solidEnvelope),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(onPressed: () {}, child: Text("Update".tr))),
          ],
        ),
      ),
    );
  }
}
