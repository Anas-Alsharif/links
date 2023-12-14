import 'package:get/get.dart';

import '../controllers/profile_show_controller.dart';

class ProfileShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileShowController>(
      () => ProfileShowController(),
    );
  }
}
