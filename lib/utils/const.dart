import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

const ML_API_URL =
    'http://ec2-13-124-37-77.ap-northeast-2.compute.amazonaws.com:5001';

class CSV {
  static final line = Null;
  CSV() {
    _loadCSV();
  }
  static void _loadCSV() {
    // final input = new File('a/csv/file.txt').openRead();
    // final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
    final File file = new File(
        "/Users/0hyun/Desktop/flutter/flutter_test_proj/dart_test/dart_test/data.csv");
    final line = file.readAsLinesSync();
    print(line);
    print(line.runtimeType);
    for (var li in line) {
      print(li);
    }
    var list = [for (var l in line) int.parse(l)];
    print(list);
    print(list.runtimeType);
    // print(file);
    Stream<List> inputStream = file.openRead();
  }
}

class CustomColors {
  static const kLightPinkColor = Color(0xffF3BBEC);
  static const kYellowColor = Color(0xffF3AA26);
  static const kCyanColor = Color(0xff0eaeb4);
  static const kPurpleColor = Color(0xff533DC6);
  static const kPrimaryColor = Color(0xff39439f);
  static const kBackgroundColor = Color(0xffF3F3F3);
  static const kLightColor = Color(0xffc4bbcc);
}

class Constants {
  // Name
  static String appName = "Rhinestone";

  // Material Design Color
  static Color lightPrimary = Color(0xfffcfcff);
  static Color lightAccent = Color(0xFF3B72FF);
  static Color lightBackground = Color(0xfffcfcff);

  static Color darkPrimary = Colors.black;
  static Color darkAccent = Color(0xFF3B72FF);
  static Color darkBackground = Colors.black;

  static Color grey = Color(0xff707070);
  static Color textPrimary = Color(0xFF486581);
  static Color textDark = Color(0xFF102A43);

  static Color backgroundColor = Color(0xFFF5F5F7);

  // Green
  static Color darkGreen = Color(0xFF3ABD6F);
  static Color lightGreen = Color(0xFFA1ECBF);

  // Yellow
  static Color darkYellow = Color(0xFF3ABD6F);
  static Color lightYellow = Color(0xFFFFDA7A);

  // Blue
  static Color darkBlue = Color(0xFF3B72FF);
  static Color lightBlue = Color(0xFF3EC6FF);

  // Orange
  static Color darkOrange = Color(0xFFFFB74D);

  static ThemeData lighTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: lightBackground,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBackground,
      textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      appBarTheme: AppBarTheme(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        iconTheme: IconThemeData(
          color: lightAccent,
        ),
      ),
    );
  }

  static double iconSize = 28.0;
  static double headerHeight = 228.5;
  static double paddingSide = 30.0;
}
