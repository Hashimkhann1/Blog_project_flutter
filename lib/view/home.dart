import 'package:crud_practice/utils/color_resource.dart';
import 'package:crud_practice/view/posts/add_post.dart';
import 'package:flutter/material.dart';


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
          body: Column(
            children: <Widget>[
              
            ],
          ),
        )
    );
  }
}
