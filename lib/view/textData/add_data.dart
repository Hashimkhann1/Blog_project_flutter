import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/Widgets/custom_text_button.dart';
import 'package:crud_practice/Widgets/custom_textfield.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class AddData extends StatelessWidget {
  AddData({Key? key});
  String? title;
  String? blogDescripition;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: ColorResource.whiteColor,
                    boxShadow: [
                      BoxShadow(color: ColorResource.blackColor,blurRadius: 5)
                    ]
                  ),
                  child: IconButton(onPressed: (){Navigator.pop(context);},
                      icon: Icon(Icons.arrow_back_ios,)),
                ),
                Center(
                  child: AppText(
                    text: 'Add Your Blog',
                    textSize: 34.0,
                    textFontWeight: FontWeight.w800,
                    textColor: ColorResource.lightBlackColor,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                customTextField(
                  fieldValueChanged: (value){
                  title = value;
                },
                ),
                SizedBox(
                  height: 10.0,
                ),
                customTextField(
                  numberOflines: 10,
                  fieldValueChanged: (value){
                    blogDescripition = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: CustomTextButton(
                    btnText: 'Add Blog',
                    btnBackgroundColor: ColorResource.lightGreenColor,
                    btnPadding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    btntextColor: ColorResource.blackColor,
                    btnTextSize: 17.0,
                    btnFontWeight: FontWeight.w600,
                    pressed: (){
                      _firestore.collection('blog').add({
                        'Title' : title,
                        'BlogDecsripiton' : blogDescripition
                      }).catchError((error){print('error while adding data in database $error');});
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
