import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/core/settings_service.dart';
import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp();

  Get.lazyPut(() => SettingsService());
  bool isDarkMode = GetStorage().read('isDarkMode') ?? true;
  if (GetStorage().read('lang') == null) {
    GetStorage().write('lang', 'ar');
  }
  if (GetStorage().read('lang') == null) {
    GetStorage().write('lang', 'ar');
  }
  String? userId = GetStorage().read("id");

  runApp(
    GetMaterialApp(
      title: 'Links',
      debugShowCheckedModeBanner: false,
      initialRoute: userId == null ? Routes.LOGIN : Routes.MAIN_SCREEN,
      getPages: AppPages.routes,

      // Configurations
      translationsKeys: AppTranslation.translations,
      locale: Locale(GetStorage().read('lang')),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: Get.find<SettingsService>().getLightTheme(),
      darkTheme: Get.find<SettingsService>().getDarkTheme(),
    ),
  );
}
