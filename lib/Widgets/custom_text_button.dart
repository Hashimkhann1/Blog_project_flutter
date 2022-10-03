import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({required this.btnText,this.pressed,this.btnFontWeight,this.btnTextSize,this.btntextColor,this.btnPadding,this.btnBackgroundColor});
  String? btnText;
  VoidCallback? pressed;
  Color? btntextColor;
  double? btnTextSize;
  FontWeight? btnFontWeight;
  Color? btnBackgroundColor;
  EdgeInsets? btnPadding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: btnBackgroundColor,
        padding: btnPadding,
      ),
        onPressed: pressed,
        child:
        Text(btnText.toString(),
          style: TextStyle(
            color: btntextColor,
            fontSize: btnTextSize,
            fontWeight: btnFontWeight
          ),
        )
    );
  }
}
