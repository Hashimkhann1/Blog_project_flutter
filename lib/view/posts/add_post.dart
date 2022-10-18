import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_practice/Widgets/custom_text_button.dart';
import 'package:crud_practice/provider/select_image_provider.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Widgets/custom_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';


final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String? downloadUrl;
  String? postTitle;
  String? postDescripition;
  bool isLoading = false;

  Future uploadImage(File _image) async {

    String? url;
    String randomImageName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference refference =
        FirebaseStorage.instance.ref().child('imageID$randomImageName');
    await refference.putFile(_image);
    url = await refference.getDownloadURL();
    return url;
  }

  void addDataToDatabast(BuildContext context) async{

    final imageProvider = Provider.of<selectGalleryImageProvider>(context,listen: false);
    isLoading = true;
    try {
      final imageUrl = await uploadImage(imageProvider.image!);
      await _firestore.collection('blog').add({
        'title': postTitle,
        'descripition': postDescripition,
        'imageUrl': imageUrl,
        'date' : DateFormat('dd MMM yyyy').format(DateTime.now()),
        'userBlog' : _auth.currentUser?.email
      });
      toastMessage('Bloag upload succesfully');
      isLoading = false;
      Navigator.pop(context);
    }catch(error){
      print('error while uploading blog $error');
      toastMessage(error.toString());
    }
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: ColorResource.blackColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {

    final imageProvider = Provider.of<selectGalleryImageProvider>(context,listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Upload New Blog'),
        backgroundColor: ColorResource.lightBlackColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<selectGalleryImageProvider>(context,listen: false).getImage();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .5,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Consumer<selectGalleryImageProvider>(builder: (context , value , child){
                      return value.image != null
                          ? Consumer(builder: (context , value , child){
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            // _image!.absolute,
                            imageProvider.image!.absolute,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        );
                      })
                          : Container(
                        decoration: BoxDecoration(
                            color: ColorResource.lightgray,
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(color: ColorResource.grayColor)),
                        width: 120,
                        height: 120,
                        child: Icon(
                          Icons.camera_alt,
                          color: ColorResource.lightBlue,
                        ),
                      );
                    },)
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            customTextField(
              hintText: 'Title',
              lableText: 'Enter Blog Title',
              fieldValueChanged: (value){
                postTitle = value;
              },
            ),
            SizedBox(
              height: 12,
            ),
            customTextField(
              hintText: 'Descripition',
              lableText: 'Enter Blog Descripition',
              fieldValueChanged: (value) {
                postDescripition = value;
              },
            ),
            SizedBox(
              height: 26,
            ),
            isLoading ? CircularProgressIndicator() : CustomTextButton(
              btnText: 'Upload Blog',
              btnBackgroundColor: ColorResource.blackColor,
              btnPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .3,
                vertical: 20,
              ),
              btntextColor: ColorResource.whiteColor,
              pressed: () {
                addDataToDatabast(context);
              },
            ),
            SizedBox(height: 10.0,)
          ],
        ),
      ),
    ));
  }
}
