import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mineapp/constants/Constantcolors.dart';

class ChatroomHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  showCreateChatRoomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: constantColors.greyColor),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4,
                    color: constantColors.whiteColor,
                  ),
                ),
                Text(
                  "Select Chatroom Avatar",
                  style: TextStyle(
                      color: constantColors.greenColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                )
              ],
            ),
          );
        });
  }
}
