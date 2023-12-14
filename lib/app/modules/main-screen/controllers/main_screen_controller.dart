import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:links/app/modules/home/views/home_view.dart';
import 'package:links/app/modules/profile/views/profile_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreenController extends GetxController {
  RxInt index = 0.obs;

  List<Widget> buildScreens() {
    return const [
      HomeView(), 
      ProfileView()];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.house),
        activeColorPrimary: Colors.white,
        title: "",
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.userGear),
        activeColorPrimary: Colors.white,
        title: "",
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }
}
