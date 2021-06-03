import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mineapp/constants/Constantcolors.dart';

class LandingHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget bodyimage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/login.png"))),
    );
  }

  Widget TaglineText(BuildContext context) {
    return Positioned(
        top: 450,
        left: 30,
        child: Container(
          constraints: BoxConstraints(maxWidth: 200),
          child: RichText(
            text: TextSpan(
                text: "Say, ",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: constantColors.blueColor,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "World ",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: constantColors.whiteColor,
                    ),
                  ),
                  TextSpan(
                    text: "is ",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: constantColors.whiteColor,
                    ),
                  ),
                  TextSpan(
                    text: "Mine",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: constantColors.blueColor,
                    ),
                  ),
                  TextSpan(
                    text: "!",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: constantColors.whiteColor,
                    ),
                  ),
                ]),
          ),
        ));
  }

  Widget mainButton(BuildContext context) {
    return Positioned(
        top: 630,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40.0,
                width: 80.0,
                decoration: BoxDecoration(
                    border: Border.all(color: constantColors.yellowColor),
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(EvaIcons.emailOutline,
                    color: constantColors.yellowColor),
              ),
              Container(
                height: 40.0,
                width: 80.0,
                decoration: BoxDecoration(
                    border: Border.all(color: constantColors.redColor),
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(EvaIcons.google, color: constantColors.redColor),
              ),
              Container(
                height: 40.0,
                width: 80.0,
                decoration: BoxDecoration(
                    border: Border.all(color: constantColors.blueColor),
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(EvaIcons.facebook, color: constantColors.blueColor),
              ),
            ],
          ),
        ));
  }

  Widget privacyText(BuildContext context) {
    return Positioned(
        top: 720,
        right: 20,
        left: 20,
        child: Column(
          children: [
            Container(
              child: Text(
                "By consulting you agree MineApp's",
                style: TextStyle(color: constantColors.greyColor, fontSize: 12),
              ),
            ),
            Container(
              child: Text(
                "Terms & Conditions",
                style: TextStyle(color: constantColors.greyColor, fontSize: 12),
              ),
            )
          ],
        ));
  }
}
