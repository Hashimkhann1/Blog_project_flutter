import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:crud_practice/view/auth/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
