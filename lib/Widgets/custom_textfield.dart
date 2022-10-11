
import 'package:crud_practice/utils/color_resource.dart';
import 'package:flutter/material.dart';


class customTextField extends StatelessWidget {
  customTextField({this.numberOflines,this.fieldValueChanged,this.hintText,this.lableText,this.icon,this.pass = false,this.keyboard});

  int? numberOflines;
  ValueChanged<String>? fieldValueChanged;
  String? hintText;
  String? lableText;
  Icon? icon;
  bool pass;
  TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        obscureText: pass,
        keyboardType: keyboard,
        onChanged: fieldValueChanged,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: lableText,
            prefixIcon: icon,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorResource.grayColor,width: 1.0),
                borderRadius: BorderRadius.circular(22.0)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide(color: ColorResource.grayColor,width: 2.0)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorResource.lightBlackColor,width: 2.0),
                borderRadius: BorderRadius.circular(22.0)
            ),
        ),
      ),
    );
  }
}