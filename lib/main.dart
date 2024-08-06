import 'dart:io';
import 'package:esc/2nsPrinttest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool isLoggedIn = false;
bool isRegistered = false;
Future<void> main() async {
  runApp(
     MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.dark,
    //   statusBarBrightness:
    //       Platform.isAndroid ? Brightness.dark : Brightness.light,
    //   systemNavigationBarColor: Colors.deepPurple,
    //   systemNavigationBarDividerColor: Colors.grey,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ));
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 112, 183, 154),
        secondaryHeaderColor: Color.fromARGB(255, 237, 231, 232),
      ),
      debugShowCheckedModeBanner: false,
      home:
          // const TEST1(),
             const TEST2(),
    );
  }
}