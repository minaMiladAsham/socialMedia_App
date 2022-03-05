import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const defaultColor = Colors.indigoAccent;
String? uId = ' ';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(color: defaultColor, fontSize: 25 , fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: defaultColor,),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.shifting,
    elevation: 10.0,
    selectedItemColor: defaultColor,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey[300],
  ),
);