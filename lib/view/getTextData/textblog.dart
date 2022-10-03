import 'package:crud_practice/utils/color_resource.dart';
import 'package:flutter/material.dart';

class TextBlog extends StatefulWidget {
  const TextBlog({Key? key}) : super(key: key);

  @override
  State<TextBlog> createState() => _TextBlogState();
}

class _TextBlogState extends State<TextBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (ctx,index){
            return Container(
              color: ColorResource.grayColor,
              margin: EdgeInsets.all(2.0),
            );
          }
      )
    );
  }
}
