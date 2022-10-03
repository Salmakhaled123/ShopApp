import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/styles/colors/colors.dart';


ThemeData darkTheme=ThemeData(fontFamily: 'Montserrat-Bold',
  primarySwatch: defaultColor,
  inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)),
      iconColor: Colors.white,
      labelStyle: TextStyle(
        color: Colors.white,
      )),
  scaffoldBackgroundColor: HexColor('333739'),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      )),
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: HexColor('333739'),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      elevation: 0.0),
  backgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor),
);
ThemeData lightTheme=ThemeData(fontFamily: 'Montserrat-Bold',
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,

    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.black)),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0.0),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 20.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        ));