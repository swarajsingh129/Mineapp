import 'package:flutter/material.dart';
import 'package:mineapp/screens/Splashscreen/Splashscreen.dart';
import 'constants/Constantcolors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MaterialApp(
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: constantColors.blueColor,
          fontFamily: "Poppins",
          canvasColor: Colors.transparent),
    );
  }
}
