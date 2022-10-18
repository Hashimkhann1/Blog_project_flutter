import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/Widgets/custom_text_button.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:crud_practice/view/posts/add_post.dart';
import 'package:crud_practice/view/posts/blog_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _firestore = FirebaseFirestore.instance;

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: ColorResource.lightBlackColor,
        automaticallyImplyLeading: false,
        title: Text('Blogs'),
        actions: [
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
        body: StreamBuilder(
          stream: _firestore.collection('blog').snapshots(),
          builder: (context , snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: SpinKitCubeGrid(
                  color: ColorResource.blackColor,
                  size: 60.0,
                ),
              );
            }
            else if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context , index){
                return Card(
                  elevation: 20,
                  margin: EdgeInsets.symmetric(horizontal: 6,vertical: 12),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: FadeInImage?.assetNetwork(
                            placeholder: 'images/loading_blog.png',
                            image: snapshot.data?.docs[index].data()['imageUrl'],
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: double.maxFinite,
                        ),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Align(alignment: Alignment.topRight, child: AppText(text: 'Pubish on ${snapshot.data?.docs[index].data()['date']}',textSize: 17.0,textFontWeight: FontWeight.w500,textColor: ColorResource.grayColor,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(text: snapshot.data?.docs[index].data()['title'].toString(),textSize: 30.0,textFontWeight: FontWeight.w700,textColor: ColorResource.lightBlackColor,),
                            AppText(text: snapshot.data!.docs[index].data()['descripition'].toString().length <= 50 ? '${snapshot.data!.docs[index].data()['descripition']}.........' : '${snapshot.data!.docs[index].data()['descripition'].toString().substring(0,100)}........' ,textSize: 16.0,textColor: ColorResource.grayColor,),
                            Row(
                              children: [
                                CustomTextButton(btnText: 'Detail',btnTextSize: 18.0,btntextColor: ColorResource.linkblueColor,btnFontWeight: FontWeight.w600,pressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(blogId: snapshot.data!.docs[index].id,)));},),
                                Icon(Icons.thumb_up_outlined,color: ColorResource.grayColor,size: 30.0,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
            }
            else if(snapshot.hasError){
              return Text('error');
            }
            return Text('return');
          },
        )
      ),
    );
  }
}
