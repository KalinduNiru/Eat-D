import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../widgets/round_raised_button.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/home_screen.dart';

class OnBoardScreen extends StatefulWidget {
  static const routeName = '/on-board';

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final User _user = FirebaseAuth.instance.currentUser;
  final List<String> images = [
    'assets/images/eat01.png',
    'assets/images/eat02.png',
    'assets/images/eat03.jpg',
    'assets/images/eat04.jpg',
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/eat01.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    aspectRatio: 16 / 5,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    }),
                items: images
                    .map((e) => Builder(
                          builder: (context) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 35.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Meet EatD, your health companion; your friend',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [0, 1, 2, 3].map((index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            RoundRaisedButton(
              text: 'Sign up',
              textColor: Colors.white,
              bgColor: AppColors.primaryColor,
              onTap: () =>
                  Navigator.pushNamed(context, RegisterScreen.routeName),
            ),
            RoundRaisedButton(
                text: 'Log in',
                textColor: AppColors.primaryColor,
                bgColor: Colors.white,
                borderColor: AppColors.primaryColor,
                onTap: () {
                  if (_user != null) {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  } else {
                    Navigator.pushNamed(context, LogInScreen.routeName);
                  }
                }),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 60,
                child: Container(
                  child: Image.asset('assets/logos/logo-word.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
