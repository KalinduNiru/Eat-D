import 'package:flutter/material.dart';

import './screens/on_board_screen.dart';
import './utils/route_generator.dart';
import './utils/material_color_genarator.dart';
import './constants/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CustomMaterialColorGenerator()
            .generateMaterialColor(AppColors.primaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: OnBoardScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
