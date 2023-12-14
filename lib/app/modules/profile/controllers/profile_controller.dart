import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  RxMap user = RxMap({});
  String userId = GetStorage().read("id");

    getUsers() async {
    DocumentSnapshot qs =
        await FirebaseFirestore.instance.collection("Users").doc(userId).get();
    user.value = qs.data() as Map;
    log(user.toString());
  }

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }
}
