import 'package:crud_practice/Widgets/custom_text_button.dart';
import 'package:crud_practice/utils/color_resource.dart';
import 'package:crud_practice/view/getData/textblog.dart';
import 'package:crud_practice/view/textData/add_data.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180.0,
              width: double.maxFinite,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ColorResource.lightBlackColor,
                    offset: Offset(0.0,1.0),
                    blurRadius: 9.0
                  )
                ],
                image: DecorationImage(
                    image: AssetImage('images/blog.jpeg'), fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: CustomTextButton(
                      btnText: 'Add Blog',
                      btnBackgroundColor: ColorResource.lightBlackColor,
                      btntextColor: ColorResource.whiteColor,
                      btnTextSize: 16.0,
                      btnPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      pressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddData()));
                      },
                    )
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Expanded(child: TextBlog()),
          ],
        ),
      ),
    );
  }
}
