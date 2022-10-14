import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/view/posts/add_post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utils/color_resource.dart';

final _firestore = FirebaseFirestore.instance;


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorResource.lightBlackColor,
            automaticallyImplyLeading: false,
            title: Text('HMK Blogs'),
            actions: [
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost()));
                  },
                  child: Icon(Icons.add,size: 34,)),
              SizedBox(width: 14.0,),
            ],
          ),
          body: Container(
            // height: double.maxFinite,
            child: FutureBuilder(
                future: _firestore.collection('blog').get(),
                builder: (context , snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Text('Loading');
                  }
                  else if(snapshot.hasData){
                    print(snapshot.data!.docs.length);
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context , index){
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: (){
                                print(snapshot.data!.docs[index].id);
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: FadeInImage.assetNetwork(placeholder: 'images/loading_blog.png', image:  '${snapshot.data!.docs[index].data()['imageUrl']}',fit: BoxFit.fitWidth,height: 340),
                                  ),
                                  Align(alignment: Alignment.topLeft,
                                  child: AppText(text: '${snapshot.data!.docs[index].data()['title']}',textSize: 30.0,)),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  else if(snapshot.hasError){
                    return Text('Error');
                  }
                  else if(snapshot.connectionState == ConnectionState.waiting){
                    return Text('Loading.....');
                  }
                  return Text('return');
                }),
          ),
        )
    );
  }
}



