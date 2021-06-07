import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mineapp/constants/Constantcolors.dart';
import 'package:mineapp/screens/Landingpage/landingpage.dart';
import 'package:page_transition/page_transition.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  ConstantColors constantColors = ConstantColors();

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: landingpage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: Center(
        child: RichText(
          text: TextSpan(
              text: "Mine",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 33,
                fontWeight: FontWeight.bold,
                color: constantColors.blueColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "App",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: constantColors.whiteColor,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
