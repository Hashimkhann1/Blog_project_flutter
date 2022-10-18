import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/Widgets/custom_text_button.dart';
import 'package:crud_practice/Widgets/custom_textfield.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:crud_practice/view/auth/login.dart';
import 'package:crud_practice/view/posts/getting_data_through_future.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Register({});
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String? email, password, name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppText(
                  text: 'Register',
                  textSize: 40.0,
                  textFontWeight: FontWeight.w700,
                  textColor: ColorResource.lightBlackColor,
                ),
                SizedBox(
                  height: 16.0,
                ),

                customTextField(
                  hintText: 'Name',
                  lableText: 'Enter Your Name',
                  icon: Icon(Icons.person),
                  fieldValueChanged: (val) {
                    name = val;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                customTextField(
                  hintText: 'Email',
                  lableText: 'Enter Your Email',
                  icon: Icon(Icons.email),
                  fieldValueChanged: (value) {
                    email = value;
                    // print(value);
                  },
                  keyboard: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 16.0,
                ),
                customTextField(
                  hintText: 'Password',
                  lableText: 'Enter Your Password',
                  icon: Icon(Icons.lock),
                  fieldValueChanged: (val) {
                    password = val;
                  },
                  pass: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CustomTextButton(
                  btnText: 'Register',
                  btntextColor: ColorResource.whiteColor,
                  btnBackgroundColor: ColorResource.blackColor,
                  btnPadding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
                  btnTextSize: 16.0,
                  pressed: () async {
                    if(name!.length !< 3){
                      showDialog(context: context, builder: (context) => AlertDialog(
                        content: Text('Name must be grater the 3 letters ?'),
                        actions: [
                          CustomTextButton(btnText: 'Ok',pressed: (){Navigator.pop(context);},)
                        ],
                      ));
                    }
                    else if(password!.length !< 7){
                      showDialog(context: context, builder: (context) => AlertDialog(
                        content: Text('password must br grater the 7 letter or Number.'),
                        actions: [
                          CustomTextButton(btnText: 'Ok',pressed: (){Navigator.pop(context);},)
                        ],
                      ));
                    }
                    else{
                      try{
                        final user = await _auth.createUserWithEmailAndPassword(email: email.toString().trim(), password: password.toString().trim());
                        if(user != null){
                          print('success');
                          toastMessage('User Successfully created');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                        }
                      }catch(error){
                        print(error);
                        toastMessage(error.toString());
                      }
                    }

                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: CustomTextButton(
                      btnText: 'Already Have Account',
                      pressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResource.blackColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
