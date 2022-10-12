import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:crud_practice/view/auth/login.dart';
import 'package:crud_practice/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToHome();
  }

  void goToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.push(context, MaterialPageRoute(builder: (context) => _auth.currentUser != null ? Home() : Login()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: AppText(
          text: 'BLOGING',
          textSize: 40.0,
          textFontWeight: FontWeight.w700,
          textColor: ColorResource.lightBlackColor,
        )),
      ),
    );
  }
}
