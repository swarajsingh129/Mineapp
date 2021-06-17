import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PostFunctions with ChangeNotifier {
  Future addLike(BuildContext context, String postId, String subDocId) async {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(subDocId)
        .set({
      "likes": FieldValue.increment(1),
      "username": Provider //incomplete yet
    });
  }
}
