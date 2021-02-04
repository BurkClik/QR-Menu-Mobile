import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadImage {
  File file;
  final picker = ImagePicker();

  UploadImage(this.file);

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      file = File(pickedFile.path);
    } else {
      print('No image selected');
    }
  }
}
