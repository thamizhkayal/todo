import 'package:flutter/material.dart';
import 'package:todo/constants/my_colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData themeData =
      ThemeData(scaffoldBackgroundColor: MyColors.kSmokeWhite);
}
