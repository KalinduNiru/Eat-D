import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;

  const CustomAppBar({Key key, @required this.title, @required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.black)),
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
