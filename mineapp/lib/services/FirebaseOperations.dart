import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mineapp/screens/Homepage/Homepage.dart';
import 'package:mineapp/screens/Landingpage/landingUtils.dart';
import 'package:mineapp/services/Authentication.dart';
import 'package:provider/provider.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask imageUploadTask;
  String initUserName, initUserEmail, initUserImage;
  bool flag = true;
  Future uploadUserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
        "userProfileAvatar/${Provider.of<landingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}");
    imageUploadTask = imageReference.putFile(
        Provider.of<landingUtils>(context, listen: false).getUserAvatar);
    imageUploadTask.whenComplete(() {
      print("File Uploaded");
      imageReference.getDownloadURL().then((value) {
        Provider.of<landingUtils>(context, listen: false).userAvatarUrl =
            value.toString();
        print(
            "user profile url${Provider.of<landingUtils>(context, listen: false).userAvatarUrl}");
        notifyListeners();
        return null;
      });
    });
    notifyListeners();
  }

  Future createUserCollection(
      BuildContext context, Map<String, dynamic> data) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    print("val of user ID----" +
        Provider.of<Authentication>(context, listen: false).getUserUid);
    return FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> doc) {
      initUserName = doc.data()["userName"];
      initUserEmail = doc.data()["userEmail"];
      initUserImage = doc.data()["userimage"];
      flag = false;
      print(initUserName);
      print(initUserEmail);
      print(initUserImage);

      notifyListeners();
    });
  }

  Future uploadPostData(Map<String, dynamic> data1, Map<String, dynamic> data2,
      String userUid) async {
    FirebaseFirestore.instance
        .collection("posts")
        .add(data1)
        .whenComplete(() {})
        .then((value) async {
      print("asasasasaasasas    " + value.id);
      FirebaseFirestore.instance
          .collection("users")
          .doc(userUid)
          .collection("posts")
          .doc(value.id)
          .set(data2);
    }).whenComplete(() {
      return print(" post uploaded    dfsdfdfd dfdfdf df dfd");
    });
  }

  Future deletePostData(String postId) async {
    return FirebaseFirestore.instance.collection("posts").doc(postId).delete();
  }

  Future updateCaption(String docId, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(docId)
        .update(data);
  }

  Future followUser(String followingUserUid, dynamic followingData,
      String followerUserUid, dynamic followerData) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(followingUserUid)
        .collection("follower")
        .doc(followerUserUid)
        .set(followingData)
        .whenComplete(() async {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(followerUserUid)
          .collection("following")
          .doc(followingUserUid)
          .set(followerData);
    });
  }

  Future unfollowUser(
      String unFollowingUserUid, String unFollowerUserUid) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(unFollowingUserUid)
        .collection("follower")
        .doc(unFollowerUserUid)
        .delete()
        .whenComplete(() {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(unFollowerUserUid)
          .collection("following")
          .doc(unFollowingUserUid)
          .delete();
    });
  }
}
