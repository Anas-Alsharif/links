import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileShowController extends GetxController {
  String link = Get.arguments["link"];
  RxMap user = RxMap({});

    getUsers() async {
      String username = link.split("/").last;
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection("Users").where("name", isEqualTo: username).get();
    user.value = qs.docs.first.data() as Map;
    log(user.toString());
  }

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }
}
