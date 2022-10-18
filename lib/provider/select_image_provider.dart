


import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class selectGalleryImageProvider with ChangeNotifier{
  File? image;
  // File get selectedImage => _image!;


  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print('picked file name ${pickedFile}');
    if(pickedFile != null){
      image = File(pickedFile.path);
      print('image provider  $image');
    }
    else{
      print('No Image Selected');
    }
    notifyListeners();
  }
}

class selectCamraImageProvider with ChangeNotifier{
  File? _image;
  File get selectedImage => _image!;

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if(pickedFile != null){
      _image = File(pickedFile.path);
      print('>>>>//>>??>>>> $_image');
    }
    else{
      print('No Image Selected');
    }
    notifyListeners();
  }
}