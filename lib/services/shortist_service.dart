import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial/forms/infotabs.dart';
import 'package:matrimonial/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore fire = Firestore.instance;

Future addToShortlist(data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  DocumentSnapshot doc =
      await fire.collection('shortlist').document(email).get();
  if (doc.exists) {
    fire
        .collection('shortlist')
        .document(email)
        .updateData({"shortlist_id": FieldValue.arrayUnion(data)});
  } else {
    fire
        .collection('shortlist')
        .document(email)
        .setData({"shortlist_id": FieldValue.arrayUnion(data)});
  }

  Fluttertoast.showToast(msg: 'Added to Shortlist');
}

Future getShortlist() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  //var profileList = <DocumentSnapshot>[];
  return fire.collection('shortlist').document(email).get();
}

getAllShortlist() {
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  // var email = prefs.getString('email');
  // var profileList = <DocumentSnapshot>[];
  // print(fire.collection('shortlist').document());
  List profiles = [];
  return fire.collection('shortlist').getDocuments().then((value) {
    return value.documents;
    //return fire.collection('shortlist').document(email).get();

    // for (int i = 0; i <= value.documents.length; i++) {
    //   return fire
    //       .collection('users')
    //       .document(value.documents[i].documentID)
    //       .get();
    // }
  });
}

Future getProfile(profiles) async {
  // print(profiles);

  return fire
      .collection('users')
      .where('Email', whereIn: profiles)
      .getDocuments();
}

getSpecificProfile(email) {
  // print(profiles);

  return fire.collection('users').document(email).get().then((value) {
    return value.data;
  });
}

Future removeProfile(profile) async {
  print(profile);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  fire
      .collection('shortlist')
      .document(email)
      .updateData({"shortlist_id": FieldValue.arrayRemove(profile)});
  Fluttertoast.showToast(msg: 'Profile Removed');
}
