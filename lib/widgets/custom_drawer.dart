import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../screens/history_screen.dart';
import '../screens/account_screen.dart';
import '../screens/blog_screen.dart';
import '../screens/on_board_screen.dart';
import '../screens/chatbot.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class CustomDrawer extends StatelessWidget {

  final Function onClose;

  const CustomDrawer({Key key, this.onClose}) : super(key: key);

  void _onItemClicked(BuildContext context, int index) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, AccountScreen.routeName);
        break;
      case 2:
        Navigator.pushNamed(context, HistoryScreen.routeName);
        break;
      case 3:
        Navigator.pushNamed(context, BlogScreen.routeName);
        break;
      case 4 :
        Navigator.pushNamed(context, Chatbot.routeName);
    }
  }



  @override

  Widget build(BuildContext context) {

    return Drawer(
      child: Container(
        color: Colors.black12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  elevation: 1,
                  textColor: Colors.white,
                  color: AppColors.secondaryColor,
                  child: Text(
                    'Tell your Success Story',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Spacer(),
            ListTile(
              leading: Icon(
                Icons.messenger_outline,
                color: AppColors.primaryColor,
              ),
              title: Text(
                'Chat with edisiuS',
                style: TextStyle(color: AppColors.primaryColor),
              ),
              onTap: () => _onItemClicked(context, 4),
            ),
            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: AppColors.primaryColor,
              ),
              title: Text(
                'Account',
                style: TextStyle(color: AppColors.primaryColor),
              ),
              onTap: () => _onItemClicked(context, 1),
            ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: AppColors.primaryColor,
              ),
              title: Text(
                'History',
                style: TextStyle(color: AppColors.primaryColor),
              ),
              onTap: () => _onItemClicked(context, 2),
            ),
            ListTile(
              leading: Icon(
                Icons.radio,
                color: AppColors.primaryColor,
              ),
              title: Text(
                'Read Blog',
                style: TextStyle(color: AppColors.primaryColor),
              ),
              onTap: () => _onItemClicked(context, 3),
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: AppColors.primaryColor,
              ),
              title: Text(
                'About',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: AppColors.primaryColor,
              ),
              title: Text(
                'Settings',
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.work_off_outlined,
                color: AppColors.primaryColor,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(color: AppColors.primaryColor),
              ),
              onTap: () async {
                //final User user = await _auth.currentUser;
                await _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, OnBoardScreen.routeName, (route) => false);
                },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(8),
                child: IconButton(
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: 30,
                    color: Colors.black54,
                  ),
                  onPressed: onClose,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

