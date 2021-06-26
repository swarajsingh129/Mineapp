import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mineapp/constants/Constantcolors.dart';
import 'package:mineapp/screens/Homepage/Homepage.dart';
import 'package:page_transition/page_transition.dart';

class AltProfileHelper with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: Homepage(), type: PageTransitionType.leftToRight));
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: constantColors.whiteColor,
          )),
      title: RichText(
        text: TextSpan(
          text: "Mine",
          style: TextStyle(
              color: constantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: "Profile",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: constantColors.blueColor))
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    child: Homepage(), type: PageTransitionType.leftToRight));
          },
          icon: Icon(EvaIcons.moreVertical),
          color: constantColors.whiteColor,
        )
      ],
    );
  }
}
