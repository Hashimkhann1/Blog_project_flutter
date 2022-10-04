import 'package:crud_practice/utils/color_resource.dart';
import 'package:flutter/material.dart';

class TextBlog extends StatefulWidget {
  const TextBlog({Key? key}) : super(key: key);

  @override
  State<TextBlog> createState() => _TextBlogState();
}

class _TextBlogState extends State<TextBlog> {

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 10));
    return 'https://miro.medium.com/max/775/0*rZecOAy_WVr16810';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (ctx,index){
            return FutureBuilder(
              future: getData(),
                builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator(strokeWidth: 20.0,);
              }
              else{
                return Container(
                    margin: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                        color: ColorResource.grayColor,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: NetworkImage(snapshot.data.toString()),
                            fit: BoxFit.cover
                        )
                    ),
                  );
              }

            });
          }
      )
    );
  }
}


