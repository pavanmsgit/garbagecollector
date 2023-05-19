import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/posters.dart';
import '../preferences/userDataPrefs.dart';


class PosterService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  String phone = UserData().getUserEmail();

  ///GETS ALL NEWS RESPONSE - ADDED BY ADMIN
  ///GETS LATEST 50 NEWS ITEMS
  Future allPosters() async {
    var res = await firebaseFirestore
        .collection('posters')
        .orderBy("posterDate", descending: true)
        .limit(50)
        .get();

    return newsFromJson(res.docs);
  }
}
