import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> getImage() async {
  final picker = ImagePicker();
  XFile? image = await picker.pickImage(
      source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

  if (image != null) {
    return File(image.path);
  } else {
    return null;
  }
}

Future<List<File>> getImages(int count) async {
  final picker = ImagePicker();

  List<XFile> xfileList = await picker.pickMultiImage(limit: 6 - count);
  return xfileList.map((xfile) => File(xfile.path)).toList();
}
