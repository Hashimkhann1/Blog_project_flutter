import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/view/posts/add_post.dart';
import 'package:crud_practice/view/posts/blog_detail.dart';
import 'package:crud_practice/view/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/color_resource.dart';

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
              TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Blogs()));}, child: Text('stream')),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddPost()));
                  },
                  child: Icon(
                    Icons.add,
                    size: 34,
                  )),
              SizedBox(
                width: 14.0,
              ),
            ],
          ),
      body: Container(
        // height: double.maxFinite,
        child: FutureBuilder(
            future: _firestore.collection('blog').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitCubeGrid(
                    color: ColorResource.blackColor,
                    size: 60.0,
                  ),
                );
              } else if (snapshot.hasData) {
                print(snapshot.data!.docs.length);
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        // padding: EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            print('taped');
                            var dataId = snapshot.data!.docs[index].id;
                            print(dataId);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(blogId: dataId.toString(),)));
                            // print(snapshot.data!.docs[index].id);
                          },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'images/loading_blog.png',
                                    image:
                                        '${snapshot.data!.docs[index].data()['imageUrl']}',
                                    fit: BoxFit.fill,
                                    width: double.maxFinite,
                                    height: MediaQuery.of(context).size.height * 0.5),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 14, bottom: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        text:
                                            '${snapshot.data!.docs[index].data()['title']}',
                                        textSize: 26.0,
                                        textColor:
                                            ColorResource.lightBlackColor,
                                        textFontWeight: FontWeight.w600,
                                      ),
                                      AppText(
                                        text: snapshot.data!.docs[index]
                                                    .data()['descripition']
                                                    .toString()
                                                    .length <=
                                                50
                                            ? '${snapshot.data!.docs[index].data()['descripition']} ........'
                                            : '${snapshot.data!.docs[index].data()['descripition'].toString().substring(1, 100)} ........',
                                        textColor: ColorResource.grayColor,
                                        textSize: 17.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('Error');
              }
              return Text('return');
            }),
      ),
    ));
  }
}

// Center(
// child: SizedBox(
// height: 80.0,
// width: 80.0,
// child: CircularProgressIndicator(
// color: ColorResource.lightBlackColor,
// strokeWidth: 18,
// )));