import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tsdo/constant.dart';
import 'package:tsdo/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor.withAlpha(100)));
    return GetMaterialApp(
      title: 'TsDo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: primaryColor,
          fontFamily: GoogleFonts.ptSans().fontFamily),
      home: const HomePage(),
    );
  }
}
