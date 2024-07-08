import 'package:expense_tracker_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var kPrimaryColor = ColorScheme.fromSeed(seedColor: Colors.blue);

  var kDarkColor =
      ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: Colors.blue);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData().copyWith(
        colorScheme: kDarkColor,
        scaffoldBackgroundColor: Colors.black,
        cardTheme: CardTheme().copyWith(
          color: kDarkColor.secondaryContainer,
          margin: EdgeInsets.only(
            top: 12,
          ),
        ),
        textTheme: TextTheme().copyWith(
          titleMedium: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              kDarkColor.secondaryContainer,
            ),
            foregroundColor: MaterialStateProperty.all(
              kDarkColor.onSecondaryContainer,
            ),
          ),
        ),
        iconTheme: IconThemeData().copyWith(
          color: Colors.white,
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kPrimaryColor,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kPrimaryColor.primary,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme().copyWith(
          color: kPrimaryColor.secondaryContainer,
          margin: EdgeInsets.only(
            top: 12,
          ),
        ),
        textTheme: TextTheme().copyWith(
          titleMedium: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              kPrimaryColor.primaryContainer,
            ),
            foregroundColor: MaterialStateProperty.all(
              kPrimaryColor.onPrimaryContainer,
            ),
          ),
        ),
        iconTheme: IconThemeData().copyWith(
          color: Colors.black,
        ),
      ),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
