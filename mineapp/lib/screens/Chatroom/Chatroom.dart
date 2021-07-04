import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mineapp/constants/Constantcolors.dart';

class Chatroom extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.plus,
            color: constantColors.greenColor,
          ),
          onPressed: null,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                EvaIcons.moreVertical,
                color: constantColors.whiteColor,
              ))
        ],
        backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
        title: RichText(
          text: TextSpan(
              text: "Mine",
              style: TextStyle(
                color: constantColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: "Chat",
                    style: TextStyle(
                        color: constantColors.blueColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ]),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          FontAwesomeIcons.plus,
          color: constantColors.greenColor,
        ),
        backgroundColor: constantColors.blueGreyColor,
      ),*/
      body: Center(
        child: Text("Chatroom"),
      ),
    );
  }
}
