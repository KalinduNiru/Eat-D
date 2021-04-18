import 'package:flutter/material.dart';

import '../screens/on_board_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/history_screen.dart';
import '../screens/account_screen.dart';
import '../screens/blog_screen.dart';
import '../screens/blog_post_add.dart';
import '../screens/chatbot.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case OnBoardScreen.routeName:
        return MaterialPageRoute(builder: (context) => OnBoardScreen());
      case LogInScreen.routeName:
        return MaterialPageRoute(builder: (context) => LogInScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case HistoryScreen.routeName:
        return MaterialPageRoute(builder: (context) => HistoryScreen());
      case AccountScreen.routeName:
        return MaterialPageRoute(builder: (context) => AccountScreen());
      case BlogScreen.routeName:
        return MaterialPageRoute(builder: (context) => BlogScreen());
      case CreateBlog.routeName:
        return MaterialPageRoute(builder: (context)=> CreateBlog());
      case Chatbot.routeName:
        return MaterialPageRoute(builder: (context) => Chatbot());
    }
  }
}