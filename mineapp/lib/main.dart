import 'package:flutter/material.dart';
import 'package:mineapp/screens/Landingpage/landinghelper.dart';
import 'package:mineapp/screens/Splashscreen/Splashscreen.dart';
import 'package:provider/provider.dart';
import 'constants/Constantcolors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
        child: MaterialApp(
          home: Splashscreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              accentColor: constantColors.blueColor,
              fontFamily: "Poppins",
              canvasColor: Colors.transparent),
        ),
        providers: [ChangeNotifierProvider(create: (_) => LandingHelpers())]);
  }
}
