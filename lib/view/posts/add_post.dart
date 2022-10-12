import 'dart:io';
import 'package:crud_practice/Widgets/custom_text_button.dart';
import 'package:crud_practice/provider/select_image_provider.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../Widgets/custom_textfield.dart';


class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? _image; // check !!
  File? gallerySelectedImage;


  void imageDialog(context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        content: Container(
          height: 120,
          child: Column(
            children: <Widget>[
             Consumer<selectGalleryImageProvider>(builder: (context , value , child){
               return  InkWell(
                 onTap: () async {
                   await value.getImage();
                   gallerySelectedImage = value.selectedImage;
                   setState(() {

                   });
                   Navigator.pop(context);
                 },
                 child: ListTile(
                   leading: Icon(Icons.photo_library),
                   title: Text('Gallery'),
                 ),
               );
             }),
              Consumer<selectCamraImageProvider>(builder: (context , value , child){
                return InkWell(
                  onTap: () async {
                     await value.getImage();
                    gallerySelectedImage = value.selectedImage;
                    setState(() {

                    });
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camraf'),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Upload New Blog'),
            backgroundColor: ColorResource.lightBlackColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 60,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width * 1,
                      child: gallerySelectedImage != null ? ClipRect(
                        child: Image.file(
                            gallerySelectedImage!.absolute,
                          width: 100,
                            height: 100,
                          fit: BoxFit.fill,
                        ),
                      ) :
                      InkWell(
                        onTap: () {
                          imageDialog(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorResource.lightgray,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorResource.grayColor)
                          ),
                          width: 120,
                          height: 120,
                          child: Icon(
                            Icons.camera_alt,
                            color: ColorResource.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 22,),
                customTextField(hintText: 'Title',lableText: 'Enter Blog Title',),
                SizedBox(height: 12,),
                customTextField(hintText: 'Descripition',lableText: 'Enter Blog Descripition',),
                SizedBox(height: 26,),
                CustomTextButton(btnText: 'Upload Blog',btnBackgroundColor: ColorResource.blackColor,btnPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .3,vertical: 20,),btntextColor: ColorResource.whiteColor,)

              ],
            ),
          ),
        )
    );
  }
}
