import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color(0xff5D9CEC);
  static Color whiteColor = Color(0xffffffff);
  static Color blackColor = Color(0xff383838);
  static Color greenColor = Color(0xff61E757);
  static Color backgroundLightColor = Color(0xffDFECDB);
  static Color backgroundDarkColor = Color(
      0xff060E1E); // Changed to the new dark background color
  static Color redColor = Color(0xffEC4B4B);
  static Color greyColor = Color(0xff7a7474);
  static Color blackDarkColor = Color(
      0xff141922); // Changed to the new dark text color

  static ThemeData lightmode = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundLightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: primaryColor,
          width: 4,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: whiteColor,
          width: 6,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: whiteColor,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      titleSmall: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: blackColor,
      ),
    ),
  );

  static ThemeData darkmode = ThemeData(
    primaryColor: primaryColor,
    // Keeping the primary color same as appBar color
    scaffoldBackgroundColor: backgroundDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor, // Setting app bar color to #5D9CEC
      elevation: 0,
      titleTextStyle: TextStyle(
        color: backgroundDarkColor, // Setting app bar title color to #060E1E
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      // Setting selected tabs color to #5D9CEC
      unselectedItemColor: whiteColor,
      // Setting unselected tabs color to white
      backgroundColor: blackColor,
      // Setting bottom navigation bar background color to #141922
      elevation: 0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: primaryColor,
          width: 4,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: whiteColor,
          width: 6,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: whiteColor, // Change the color to white
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: whiteColor, // Change the color to white
      ),
      titleSmall: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: whiteColor, // Change the color to white
      ),
    ),
  );
}