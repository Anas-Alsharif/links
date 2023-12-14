import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'colors.dart';

class SettingsService extends GetxService {
  String font = GetStorage().read('lang') == "en" ? 'en_font' : 'ar_font';
  ThemeData getLightTheme() {
    return ThemeData(
        fontFamily: font,
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: font,
                ))),
        brightness: Brightness.light,
        dividerTheme: DividerThemeData(color: AppColors.lightFieldColor),
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.lightFieldColor,
            prefixIconColor: AppColors.primaryColor,
            suffixIconColor: AppColors.primaryColor.withOpacity(.5),
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 25.0, height: 1.3),
          headlineSmall: TextStyle(fontSize: 16.0, height: 1.3),
          headlineMedium: TextStyle(fontSize: 18.0, height: 1.3),
          displaySmall: TextStyle(fontSize: 20.0, height: 1.3),
          displayMedium: TextStyle(fontSize: 22.0, height: 1.4),
          displayLarge: TextStyle(fontSize: 24.0, height: 1.4),
          titleSmall: TextStyle(fontSize: 15.0, height: 1.2),
          titleMedium: TextStyle(fontSize: 15.0, height: 1.2),
          bodyMedium: TextStyle(fontSize: 13.0, height: 1.2),
          bodyLarge: TextStyle(fontSize: 12.0, height: 1.2),
          bodySmall: TextStyle(fontSize: 12.0, height: 1.2),
        ));
  }

  ThemeData getDarkTheme() {
    return ThemeData(
        fontFamily: GetStorage().read('lang') == "en" ? '' : 'ar_font',
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: font,
                ))),
        brightness: Brightness.dark,
        dividerTheme: const DividerThemeData(color: Colors.white38),
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppColors.darkFieldColor,
            prefixIconColor: Colors.white,
            suffixIconColor: Colors.white.withOpacity(.5),
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white),
        textTheme: const TextTheme(
          titleLarge:
              TextStyle(fontSize: 25.0, color: Colors.white, height: 1.3),
          headlineSmall: TextStyle(fontSize: 16.0, height: 1.3),
          headlineMedium: TextStyle(fontSize: 18.0, height: 1.3),
          displaySmall: TextStyle(fontSize: 20.0, height: 1.3),
          displayMedium: TextStyle(fontSize: 22.0, height: 1.4),
          displayLarge: TextStyle(fontSize: 24.0, height: 1.4),
          titleSmall: TextStyle(fontSize: 15.0, height: 1.2),
          titleMedium:
              TextStyle(fontSize: 15.0, color: Colors.white, height: 1.2),
          bodyMedium: TextStyle(fontSize: 13.0, height: 1.2),
          bodyLarge:
              TextStyle(fontSize: 12.0, color: Colors.white, height: 1.2),
          bodySmall: TextStyle(fontSize: 12.0, height: 1.2),
        ).apply(bodyColor: Colors.white));
  }
}
