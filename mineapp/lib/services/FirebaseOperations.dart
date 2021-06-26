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

  Future uploadPostData(String postId, Map<String, dynamic> data) async {
    return FirebaseFirestore.instance.collection("posts").doc(postId).set(data);
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
}
