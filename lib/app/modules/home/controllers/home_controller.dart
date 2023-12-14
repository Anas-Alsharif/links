import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  RxMap user = RxMap({});
  RxList users = RxList([]);
  RxList links = RxList([]);
  String userId = GetStorage().read("id");

  getProfileData() async {
    DocumentSnapshot qs =
        await FirebaseFirestore.instance.collection("Users").doc(userId).get();
    user.value = qs.data() as Map;
    links.value = user["links"];
  }

  getUsers() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection("Users").get();
    users.value = qs.docs;
  }

  shareLink({required String id, required bool share}) async {
    if (!share) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .update({
        "links": FieldValue.arrayRemove([user['link']])
      });
    } else {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .update({"links": FieldValue.arrayUnion([user['link']])});
    }
    getUsers();
  }

  @override
  void onInit() {
    super.onInit();
    getProfileData();
    getUsers();
  }
}
