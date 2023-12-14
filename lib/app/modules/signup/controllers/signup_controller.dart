import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/alert.dart';
import '../../../core/images.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool obscureText = true.obs;
  RxBool loading = false.obs;

  Rxn<File> image = Rxn<File>();

  signup() async {
    if (username.text.trim().isEmpty) {
      return Get.showSnackbar(
          Ui.DefaultSnackBar(message: "Please enter the username".tr));
    }
    if (email.text.trim().isEmpty) {
      return Get.showSnackbar(
          Ui.DefaultSnackBar(message: "Please enter the email".tr));
    }
    if (password.text.trim().isEmpty) {
      return Get.showSnackbar(
          Ui.DefaultSnackBar(message: "Please enter the password".tr));
    }

    try {
      loading.value = true;
      if (!await checkUserNotUsed(username.text)) {
        loading.value = false;
        return Get.showSnackbar(
            Ui.ErrorSnackBar(message: "The user name is already in used".tr));
      }
      UserCredential cred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      String downloadUrl = "";
      if (image.value != null) {
        downloadUrl = await _uploadToStorage(image.value!);
      }
      Map<String, dynamic> body = {
        "name": username.text,
        "email": email.text,
        "uid": cred.user!.uid,
        "image": downloadUrl == "" ? AppImages.logo : downloadUrl,
        "link": "www.link.com/${username.text}",
        "links": []
      };
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(cred.user!.uid)
          .set(body);
          GetStorage().write("id", cred.user!.uid);
      Get.offAllNamed(Routes.MAIN_SCREEN);
      loading.value = false;
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      if (e.code == 'weak-password') {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: "Password must be at least 6 characters long".tr));
      } else if (e.code == 'email-already-in-use') {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: "Email address already in use".tr));
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.code));
      }
    }
  }

  Future<bool> checkUserNotUsed(String newUserName) async {
    var usersCollection = FirebaseFirestore.instance.collection("Users");
    var querySnapshot =
        await usersCollection.where("name", isEqualTo: newUserName).get();
    return querySnapshot.docs.isEmpty;
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
