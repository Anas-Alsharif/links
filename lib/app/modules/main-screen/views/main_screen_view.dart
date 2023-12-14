import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../core/colors.dart';
import '../controllers/main_screen_controller.dart';

class MainScreenView extends GetView<MainScreenController> {
  const MainScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: controller.buildScreens(),
      items: controller.navBarsItems(),
      backgroundColor: AppColors.primaryColor,
      confineInSafeArea: false,
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(50)),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
