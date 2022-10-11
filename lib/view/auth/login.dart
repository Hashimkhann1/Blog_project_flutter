import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/Widgets/custom_text_button.dart';
import 'package:crud_practice/Widgets/custom_textfield.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:crud_practice/view/auth/register.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

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
              ),
              SizedBox(
                height: 16.0,
              ),
              customTextField(
                hintText: 'Password',
                lableText: 'Enter your Password',
                icon: Icon(Icons.lock),
                pass: true,
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
              ),
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
}
