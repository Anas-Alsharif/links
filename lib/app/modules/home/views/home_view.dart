import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:links/app/core/alert.dart';
import 'package:links/app/core/colors.dart';
import 'package:links/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: Text('Link'.tr),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                Row(
                  children: [
                    controller.user.isEmpty
                        ? SpinKitRipple(color: AppColors.primaryColor, size: 15)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(controller.user['image'],
                                width: 60, height: 60, fit: BoxFit.cover)),
                    const SizedBox(width: 10),
                    Text("Hello ".tr, style: const TextStyle(fontSize: 18)),
                    controller.user.isEmpty
                        ? SpinKitThreeBounce(
                            color: AppColors.primaryColor, size: 15)
                        : Text("${controller.user['name']}!",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w900)),
                  ],
                ),
                const SizedBox(height: 30),
                const Text("Now you can share Your Link",
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                controller.user.isEmpty
                    ? SpinKitThreeBounce(
                        color: AppColors.primaryColor, size: 20)
                    : Text(controller.user['link'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                TextButton.icon(
                    onPressed: () => shareLink(),
                    label: Text("Share Link".tr),
                    icon: const Icon(FontAwesomeIcons.link)),
                const Divider(height: 50),
                Row(
                  children: [
                    Text("Links shared with me".tr),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  direction: Axis.vertical,
                  children: List.generate(
                      controller.links.length,
                      (index) => GestureDetector(
                            onTap: () => Get.toNamed(Routes.PROFILE_SHOW,
                                arguments: {"link": controller.links[index]}),
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: Get.width - 70,
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    const Icon(FontAwesomeIcons.link, size: 12),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: Text(
                                      controller.links[index],
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.start,
                                    )),
                                    Tooltip(
                                      message: "Copy".tr,
                                      waitDuration: Duration.zero,
                                      child: IconButton(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: controller.links[index]));
                                            Get.showSnackbar(Ui.SuccessSnackBar(
                                                message:
                                                    "Link has been copy successfully"
                                                        .tr));
                                          },
                                          icon: const Icon(Icons.copy,
                                              size: 20, color: Colors.white38)),
                                    )
                                  ],
                                )),
                          )),
                )
              ],
            ),
          ));
    });
  }

  shareLink() => Get.bottomSheet(
        Column(
          children: [
            Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: 100,
                    height: 7,
                    decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(20)))),
            TextField(
              decoration: InputDecoration(
                  hintText: "Search".tr,
                  prefixIcon: const Icon(FontAwesomeIcons.search)),
            ).marginSymmetric(horizontal: 20, vertical: 10),
            Expanded(
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: controller.users.length,
                  itemBuilder: (_, index) {
                    RxList links = RxList(controller.users[index]["links"]);
                    return controller.users[index].id == controller.userId &&
                            controller.users.length == 1
                        ? Center(
                            child: Text("No Users Found!".tr),
                          )
                        : controller.users[index].id == controller.userId
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Obx(() {
                                        return CupertinoCheckbox(
                                            value: links.contains(
                                                controller.user["link"]),
                                            onChanged: (value) {
                                              if (links.contains(
                                                  controller.user["link"])) {
                                                links.remove(
                                                    controller.user["link"]);
                                                controller.shareLink(
                                                    id: controller
                                                        .users[index].id,
                                                    share: false);
                                              } else {
                                                links.add(
                                                    controller.user["link"]);
                                                controller.shareLink(
                                                    id: controller
                                                        .users[index].id,
                                                    share: true);
                                              }
                                            });
                                      }),
                                      const SizedBox(width: 5),
                                      Text(controller.users[index]["name"]),
                                    ],
                                  ),
                                  const Divider()
                                ],
                              );
                  }),
            ),
            SizedBox(
                    width: 200,
                    child: TextButton(
                        onPressed: () => Get.back(), child: Text("Finish".tr)))
                .marginOnly(bottom: 10)
          ],
        ),
        backgroundColor: Get.isDarkMode ? Colors.blueGrey[900] : Colors.white,
      );
}
