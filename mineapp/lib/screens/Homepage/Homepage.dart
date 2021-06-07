import 'package:flutter/material.dart';
import 'package:mineapp/constants/Constantcolors.dart';
import 'package:mineapp/screens/Landingpage/landinghelper.dart';
import 'package:mineapp/screens/Landingpage/landingpage.dart';
import 'package:mineapp/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.redColor,
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => Provider.of<Authentication>(context, listen: false)
              .signOutWithGoogle()
              .whenComplete(() => Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: landingpage(),
                      type: PageTransitionType.leftToRight))),
          child: Text("LOG OUT"),
        ),
      ),
    );
  }
}
