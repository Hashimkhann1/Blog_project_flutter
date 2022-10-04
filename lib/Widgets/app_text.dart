import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  AppText({required this.text,this.textSize,this.textColor,this.textFontWeight,this.cusTextAlign});
  String? text;
  double? textSize = 14.0;
  FontWeight? textFontWeight;
  Color? textColor;
  TextAlign? cusTextAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      textAlign: cusTextAlign,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: textFontWeight,
        color: textColor
      ),
    );
  }
}
