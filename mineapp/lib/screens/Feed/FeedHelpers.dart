import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mineapp/constants/Constantcolors.dart';
import 'package:mineapp/services/Authentication.dart';
import 'package:mineapp/utilites/PostOptions.dart';
import 'package:mineapp/utilites/UploadPosts.dart';
import 'package:provider/provider.dart';

class FeedHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
      actions: [
        IconButton(
          onPressed: () {
            Provider.of<UploadPosts>(context, listen: false)
                .selectPostImageType(context);
          },
          icon: Icon(
            Icons.camera_enhance_rounded,
            color: constantColors.greenColor,
          ),
        )
      ],
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
                  text: "Feeds",
                  style: TextStyle(
                      color: constantColors.blueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ]),
      ),
    );
  }

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 8.0, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection("posts")
                .orderBy("time", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    height: 400,
                    width: 500,
                    child: Lottie.asset("assets/animations/loading.json"),
                  ),
                );
              } else {
                return loadPost(context, snapshot);
              }
            },
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: constantColors.darkColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadPost(BuildContext context,
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    return new ListView(
      children: snapshot.data.docs
          .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        Provider.of<PostFunctions>(context, listen: false)
            .showTime(documentSnapshot.data()["time"]);
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: constantColors.blueGreyColor.withOpacity(0.2),
            ),

            height: MediaQuery.of(context).size.width *
                1.35, // MediaQuery.of(context).size.height * 0.68,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: constantColors.blueGreyColor,
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                              documentSnapshot.data()["userImage"]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  documentSnapshot.data()["userName"],
                                  style: TextStyle(
                                      color: constantColors.greenColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                      text: documentSnapshot.data()["caption"],
                                      style: TextStyle(
                                          color: constantColors.blueColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: Provider.of<PostFunctions>(
                                                  context,
                                                  listen: false)
                                              .getImageTimePosted,
                                          style: TextStyle(
                                            color: constantColors.lightColor
                                                .withOpacity(0.8),
                                          ),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    color: constantColors.whiteColor.withOpacity(0.9),
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      child: Image.network(
                        documentSnapshot.data()["Postdata"],
                        scale: 2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 20), //Like button
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .addLike(
                                        context,
                                        documentSnapshot.data()["caption"],
                                        Provider.of<Authentication>(context,
                                                listen: false)
                                            .getUserUid)
                                    .whenComplete(() {
                                  print("liked post");
                                });
                              },
                              child: Icon(
                                FontAwesomeIcons.heart,
                                color: constantColors.redColor,
                                size: 22,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection("posts")
                                    .doc(documentSnapshot.data()["caption"])
                                    .collection("likes")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Provider.of<PostFunctions>(context,
                                                listen: false)
                                            .showLikes(
                                                context,
                                                documentSnapshot
                                                    .data()["caption"]);
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          snapshot.data.docs.length.toString(),
                                          style: TextStyle(
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    );
                                  }
                                })
                            /* Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "0",
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            )*/
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Comment button
                            GestureDetector(
                              onTap: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showCommentSheet(context, documentSnapshot,
                                        documentSnapshot.data()["caption"]);
                              },
                              child: Icon(
                                FontAwesomeIcons.comment,
                                color: constantColors.yellowColor,
                                size: 22,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection("posts")
                                    .doc(documentSnapshot.data()["caption"])
                                    .collection("comments")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        snapshot.data.docs.length.toString(),
                                        style: TextStyle(
                                            color: constantColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    );
                                  }
                                })
                            /*Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "0",
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            )*/
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.start, //share button
                          children: [
                            GestureDetector(
                              child: Icon(
                                FontAwesomeIcons.share,
                                color: constantColors.blueColor,
                                size: 22,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "0",
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Provider.of<Authentication>(context, listen: false)
                                  .getUserUid ==
                              documentSnapshot.data()["userUid"]
                          ? IconButton(
                              onPressed: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showPostOptions(context,
                                        documentSnapshot.data()["caption"]);
                              },
                              icon: Icon(
                                EvaIcons.moreVertical,
                                color: constantColors.whiteColor,
                              ))
                          : Container(
                              height: 0,
                              width: 0,
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
