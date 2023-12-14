import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ProfileEditController extends GetxController {
  Map user = Get.arguments["user"];
  String userId = GetStorage().read("id");
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  Rxn<File> image = Rxn<File>();

    Future<File> urlToFile(String imageUrl) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(100)}.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  @override
  void onInit() async {
    super.onInit();
    username.text = user["name"];
    email.text = user["email"];
    image.value = await urlToFile(user["image"]);
  }
}
