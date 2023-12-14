import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage {
  Future imgFromCamera(image) async {
    ImagePicker()
        .pickImage(source: ImageSource.camera)
        .then((pickedFile) async {
      if (pickedFile != null) {
        await ImageCropper()
            .cropImage(sourcePath: pickedFile.path, cropStyle: CropStyle.circle)
            .then((value) {
          if (value != null) {
            image.value = File(value.path);
          }
        });
      }
    });
  }

  Future imgFromGallery(image) async {
    ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((pickedFile) async {
      if (pickedFile != null) {
        await ImageCropper()
            .cropImage(sourcePath: pickedFile.path, cropStyle: CropStyle.circle)
            .then((value) async {
          if (value != null) {
            image.value = File(value.path);
          }
        });
      }
    });
  }
}
