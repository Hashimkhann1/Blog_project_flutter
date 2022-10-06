import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance.collection('blog');
class TextBlog extends StatefulWidget {
  const TextBlog({Key? key}) : super(key: key);

  @override
  State<TextBlog> createState() => _TextBlogState();
}

class _TextBlogState extends State<TextBlog> {

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 2));
    return 'https://cdn1.expresscomputer.in/wp-content/uploads/2021/03/24161745/EC_Artificial_Intelligence_AI_750.jpg';
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
                  return CircularProgressIndicator();
                }
                else {
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


