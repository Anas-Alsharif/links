// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';

class Ui {
  static GetSnackBar SuccessSnackBar(
      {required String message,
      SnackPosition snackPosition = SnackPosition.TOP}) {
    return GetSnackBar(
      messageText: Text(
        message.tr,
        style: const TextStyle(color: Colors.white),
      ),
      snackPosition: snackPosition,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
      backgroundColor: AppColors.primaryColor,
      icon:
          const Icon(Icons.check_circle_outline, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 15,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar ErrorSnackBar(
      {required String message,
      SnackPosition snackPosition = SnackPosition.TOP}) {
    return GetSnackBar(
      messageText:
          Text(message.tr, style: const TextStyle(color: Colors.white)),
      snackPosition: snackPosition,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.remove_circle_outline,
          size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar DefaultSnackBar({required String message}) {
    return GetSnackBar(
      messageText:
          Text(message.tr, style: const TextStyle(color: Colors.black)),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      backgroundColor: AppColors.lightFieldColor,
      icon: const Icon(Icons.warning_amber_rounded,
          size: 32, color: Colors.black),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
    );
  }
}
