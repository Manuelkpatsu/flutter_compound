import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageSelector {
  Future<File?> selectImage() {
    return ImagePicker().pickImage(source: ImageSource.gallery)
        .then((xFile) => xFile == null ? null : File(xFile.path));
  }
}
