import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AboutUs extends StatefulWidget {
  static const routeName = '/about-eatd';

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About EatD', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.iconColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Image.asset(
                "assets/images/default.png",
                alignment: Alignment.topCenter,

              ),
            ),
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Eating Disorders might seem like nothing, but they should not be neglected. Even though it looks simple, if it is not treated the results could be severe and dangerous. EatD mobile application is developed to support the people with Eating Disorders.",
                  style: TextStyle(fontSize: 15.0,
                  fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Developed by Chavini Abhayasighe",
                  style: TextStyle(fontSize: 15.0,
                      ),
                  textAlign: TextAlign.center,
                )
            )
          ],
        ));
  }
}
