import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_practice/Widgets/app_text.dart';
import 'package:crud_practice/Widgets/custom_text_button.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:crud_practice/view/posts/getting_data_through_future.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _firestore = FirebaseFirestore.instance;

class BlogDetail extends StatefulWidget {
  BlogDetail({this.blogId});

  String? blogId;

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('bog testing ok');
    // print(widget.blogId);

  }

  void deleteBlog() async {
    showDialog(context: context, builder: (context) => AlertDialog(
      content: Text('Are you sure to Delete this Blog'),
      actions: [
        CustomTextButton(btnText: 'Yes i\'m Sure',pressed: () async {
          await _firestore.collection('blog').doc(widget.blogId).delete();
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        },),
        CustomTextButton(btnText: 'No Levee it',pressed: (){Navigator.pop(context);},)
      ],
    ));

  }


  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResource.lightBlackColor,
          title: Text('Blogs'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: _firestore.collection('blog').doc(widget.blogId.toString()).get(),
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
                    return Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.only(left: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image(image: NetworkImage(snapshot.data!.data()!['imageUrl']),fit: BoxFit.fill,),
                            width: double.maxFinite,
                            height: 360,
                          ),
                          SizedBox(height: 8,),
                          Align(
                              alignment: Alignment.topRight,
                              child: AppText(text: 'Publish on ${snapshot.data?.data()?['date']}',textColor: ColorResource.grayColor,textSize: 16.0,textFontWeight: FontWeight.w600,)),
                          SizedBox(height: 10,),
                          AppText(text: snapshot.data?.data()?['title'].toString().toUpperCase(),textSize: 26.0,textFontWeight: FontWeight.w600,textColor: ColorResource.lightBlackColor,),
                          SizedBox(height: 6,),
                          AppText(text: snapshot.data?.data()?['descripition'].toString(),textColor: ColorResource.blackColor,textSize: 17.0,),
                          SizedBox(height: 40,),
                          _auth.currentUser?.email == snapshot.data?.data()?['userBlog'] ? Align(
                            child: CustomTextButton(btnText: 'Delete Blog',pressed: deleteBlog,btnBackgroundColor: ColorResource.lightBlackColor,btntextColor: ColorResource.whiteColor,btnPadding: EdgeInsets.all(14),),
                            alignment: Alignment.topRight,
                          ) : Text(''),
                        ],
                      ),
                    );
                  }
                  else if(snapshot.hasError){
                    return Text('error');
                  }
                  return Text('return');
              }),
            ],
          ),
        )
      ),
    );
  }
}

