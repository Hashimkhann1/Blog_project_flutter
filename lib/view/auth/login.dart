import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/Widgets/custom_text_button.dart';
import 'package:crud_practice/Widgets/custom_textfield.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:crud_practice/view/auth/register.dart';
import 'package:crud_practice/view/posts/getting_data_through_future.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatelessWidget {
  Login({Key? key});

  FirebaseAuth _auth = FirebaseAuth.instance;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppText(
                text: 'Login',
                textSize: 44.0,
                textFontWeight: FontWeight.w700,
                textColor: ColorResource.lightBlackColor,
              ),
              SizedBox(
                height: 16.0,
              ),
              customTextField(
                hintText: 'Email',
                lableText: 'Enter your Email',
                keyboard: TextInputType.emailAddress,
                icon: Icon(Icons.email),
                fieldValueChanged: (val) {
                  email = val;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              customTextField(
                hintText: 'Password',
                lableText: 'Enter your Password',
                icon: Icon(Icons.lock),
                pass: true,
                fieldValueChanged: (val) {
                  password = val;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              CustomTextButton(
                  btnText: 'Login',
                  btnBackgroundColor: ColorResource.blackColor,
                  btntextColor: ColorResource.whiteColor,
                  btnPadding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
                  pressed: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email.toString().trim(),
                          password: password.toString().trim());
                      if (user != null) {
                        print('success');
                        toastMessage('user successfully Loged In');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      }
                    } catch (error) {
                      print(error.toString());
                      toastMessage(error.toString());
                    }
                  }),
              SizedBox(
                height: 30.0,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: CustomTextButton(
                    btnText: 'Create New Account',
                    pressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                  )),
            ],
          ),
        ),
      ),
    ));
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResource.blackColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
