import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrimonial/localstorage.dart';

//String phoneNumber;
String smsCode;
String msg;
String verificationCode;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore fire = Firestore.instance;
final FirebaseMessaging _fcm = FirebaseMessaging();
final _otp = TextEditingController();
String fileName;
String filepath;
final facebookLogin = FacebookLogin();

void loginUser(email, pass, remember, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', true);
  prefs.setString('type', 'normal');
  prefs.setString('password', pass);
  prefs.setString('email', email);
  prefs.setBool('remember', remember);
  print(email);
  Fluttertoast.showToast(
      msg: 'Login Sucessfully', toastLength: Toast.LENGTH_LONG);
  if (email == 'admin@gmail.com') {
    prefs.setBool('isAdmin', true);
    Navigator.pushReplacementNamed(context, '/admin', arguments: email);
  } else {
    prefs.setBool('isAdmin', false);
    Navigator.pushReplacementNamed(context, '/splashscreen', arguments: email);
  }
}

void registerUser(profile, remember, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', true);
  prefs.setString('username', profile['Name']);
  prefs.setString('password', profile['Pass']);
  prefs.setString('email', profile['Email']);

  prefs.setBool('remember', remember);
  // scaffoldkey.currentState.showSnackBar(snackbar('Some error occured'));

  Fluttertoast.showToast(
      msg: 'Registered Sucessfully', toastLength: Toast.LENGTH_LONG);
  if (profile['Email'] == 'admin@gmail.com') {
    Navigator.pushReplacementNamed(context, '/admin',
        arguments: profile['Email']);
  } else {
    Navigator.pushReplacementNamed(context, '/infotabs', arguments: profile);
  }
}

Widget snackbar(msg) {
  return SnackBar(
    backgroundColor: Colors.red,
    content: Text(msg),
  );
}

Future login(email, password, remember, context) async {
  await _auth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((user) => {
            // _fcm.unsubscribeFromTopic('notification'),
            loginUser(email, password, remember, context)
          })
      .catchError((onError) {
    print(onError);
    if (onError.code == 'ERROR_INVALID_EMAIL') {
      Fluttertoast.showToast(
          msg: 'Email Id is not Valid', toastLength: Toast.LENGTH_LONG);
    }
    if (onError.code == 'ERROR_WRONG_PASSWORD') {
      Fluttertoast.showToast(
          msg: 'Invalid Password', toastLength: Toast.LENGTH_LONG);
    }
    if (onError.code == 'ERROR_TOO_MANY_REQUESTS') {
      Fluttertoast.showToast(
          msg:
              'Opps.. Too many unsuccessful login attempts. Please try again later. ',
          toastLength: Toast.LENGTH_LONG);
    }
    if (onError.code == 'ERROR_USER_NOT_FOUND') {
      Fluttertoast.showToast(
          msg: 'User not found. Please register ',
          toastLength: Toast.LENGTH_LONG);
    }
  }
          // scaffoldkey.currentState
          //     .showSnackBar(snackbar('Some error occured'))
          );
}

Future register(Map profile, context, remember) async {
  await _auth
      .createUserWithEmailAndPassword(
          email: profile['Email'], password: profile['Pass'])
      .then((user) => {
            _saveDeviceToken(profile['Email']),
            addUser(profile, profile['Email'], context, remember)
          })
      .catchError((onError) => {print(onError)});
  Fluttertoast.showToast(
      msg: 'This may take few seconds...', toastLength: Toast.LENGTH_LONG);
}

Future addUser(profile, email, context, remember) async {
  var empsRef = fire.collection('users');
  empsRef
      .document(email)
      .setData(profile)
      .then((onValue) => registerUser(profile, remember, context));
}

getUser(profile, remember, context) async {
  DocumentSnapshot ds =
      await fire.collection('users').document(profile['Email']).get();
  print(ds.exists);
  //print('get user');
  if (!ds.exists) {
    register(profile, remember, context);
  } else {
    Fluttertoast.showToast(msg: 'Email id already present');
  }
}

getProfileList(email, age, caste, city) async {
  DocumentSnapshot ds = await fire.collection('users').document(email).get();
  // print(ds.data['Gender']);
  if (ds.data['Gender'] == 'Female') {
    var doc1 = fire
        .collection('users')
        .where('Gender', isEqualTo: 'Male')
        .where('Age', whereIn: age)
        .where('Caste', whereIn: caste)
        .where('City', whereIn: city);
    return doc1;
  } else {
    var doc1 = fire
        .collection('users')
        .where('Gender', isEqualTo: 'Female')
        .where('Age', whereIn: age)
        .where('Caste', whereIn: caste)
        .where('City', whereIn: city)
        .snapshots();
    return doc1;
  }
  //print('get user');
}

filterGender(email) async {
  DocumentSnapshot ds = await fire.collection('users').document(email).get();
  if (ds.data['Gender'] == 'Female') {
    return fire
        .collection('users')
        .where('Gender', isEqualTo: 'Male')
        .getDocuments()
        .then((value) {
      return value.documents;
    });
  } else {
    return fire
        .collection('users')
        .where('Gender', isEqualTo: 'Female')
        .getDocuments()
        .then((value) {
      return value.documents;
    });
  }
}

filterData(age, city, type, gender) async {
  if (type == 'Age') {
    return fire
        .collection('users')
        .where('Gender', isEqualTo: gender)
        .where('Age', isGreaterThanOrEqualTo: age['MinAge'])
        .where('Age', isLessThanOrEqualTo: age['MaxAge'])
        .getDocuments()
        .then((profiles) {
      return profiles.documents;
    });
  }
  // if (type == 'Catse') {
  //   var doc1 = data..where('Caste', isEqualTo: caste);
  //   return doc1;
  // }

  if (type == 'City') {
    return fire
        .collection('users')
        .where('Gender', isEqualTo: gender)
        .where('City', whereIn: city)
        //.where('Age', isGreaterThanOrEqualTo: age['MinAge'])
        // .where('Age', isLessThanOrEqualTo: age['MaxAge'])
        .getDocuments()
        .then((profiles) {
      return profiles.documents;
    });
  }
}

Future updateUser(email, data, context) async {
  DocumentSnapshot ds = await fire.collection('users').document(email).get();
  if (ds.exists) {
    return fire
        .collection('users')
        .document(email)
        .updateData(data)
        .then((value) => Fluttertoast.showToast(msg: 'Profile Updated'))
        .catchError((onError) => print(onError));
  } else {
    var empsRef = fire.collection('users');
    empsRef
        .document(email)
        .setData(data)
        .then((value) => Fluttertoast.showToast(msg: 'Details Added'))
        .catchError((onError) => print(onError));
  }
}

Future siginwithgoogle(context) async {
  final GoogleSignInAccount googleuser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleauth = await googleuser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleauth.accessToken, idToken: googleauth.idToken);
  final FirebaseUser firebaseUser =
      (await _auth.signInWithCredential(credential).catchError((onError) {
    if (onError.code == 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
      Fluttertoast.showToast(msg: 'Email Id Already Present');
    }
    if (onError.code == 'ERROR_INVALID_CREDENTIAL') {
      Fluttertoast.showToast(msg: 'Invalid Credentials');
    }
  }))
          .user;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', firebaseUser.email);
  prefs.setString('type', 'gmail');
  DocumentSnapshot ds =
      await fire.collection('users').document(firebaseUser.email).get();
  if (ds.exists) {
    Fluttertoast.showToast(
        msg: 'Login Sucessfully', toastLength: Toast.LENGTH_LONG);
    Navigator.pushReplacementNamed(context, '/splashscreen',
        arguments: firebaseUser.email);
  } else {
    Fluttertoast.showToast(
        msg: 'Registered Sucessfully', toastLength: Toast.LENGTH_LONG);
    Navigator.pushReplacementNamed(
      context,
      '/infotabs',
      arguments: {
        "Name": firebaseUser.displayName,
        "Email": firebaseUser.email,
        "Pass": '',
        "Mobile": 0,
        "DOB": '',
        "Address": '',
        "City": '',
        "State": '',
        "Pincode": 0,
        "Status": '',
        "Education": '',
        "Jobtype": '',
        "Job": '',
        "Salary": 0,
        "Height": '',
        "Weight": 0,
        "Complexion": '',
        "Native": '',
        "Church Name": '',
        "Church Address": '',
        "Resident": '',
        "Expectation": '',
        "Mother Tounge": '',
        "image1":
            'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
        "image2":
            'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
        "image3":
            'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
        "Bio Headline": '',
        "Age": '',
        "Gender": ''
      },
    );
  }
}

Future<FirebaseUser> firebaseAuthWithFacebook(context,
    {@required FacebookAccessToken token}) async {
  AuthCredential credential =
      FacebookAuthProvider.getCredential(accessToken: token.token);
  AuthResult firebaseUser = await _auth
      .signInWithCredential(credential)
      .then((onValue) {})
      .catchError((onError) {
    if (onError.code == 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL') {
      Fluttertoast.showToast(msg: 'Email Id Already Present');
    }
    if (onError.code == 'ERROR_INVALID_CREDENTIAL') {
      Fluttertoast.showToast(msg: 'Invalid Credentials');
    }
  });
  var email = firebaseUser.user.email;

  DocumentSnapshot ds = await fire.collection('users').document(email).get();
  if (ds.exists) {
    Fluttertoast.showToast(
        msg: 'Login Successfully', toastLength: Toast.LENGTH_LONG);
    Navigator.pushReplacementNamed(context, '/splashscreen', arguments: email);
  } else {
    Fluttertoast.showToast(
        msg: 'Registered Successfully', toastLength: Toast.LENGTH_LONG);
    Navigator.pushReplacementNamed(
      context,
      '/infotabs',
      arguments: {
        "Name": firebaseUser.user.displayName,
        "Email": firebaseUser.user.email,
        "Pass": '',
        "Mobile": 0,
        "DOB": '',
        "Address": '',
        "City": '',
        "State": '',
        "Pincode": 0,
        "Status": '',
        "Education": '',
        "Jobtype": '',
        "Job": '',
        "Salary": 0,
        "Height": '',
        "Weight": 0,
        "Complexion": '',
        "Native": '',
        "Church Name": '',
        "Church Address": '',
        "Resident": '',
        "Expectation": '',
        "Mother Tounge": '',
        "image1":
            'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
        "image2":
            'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
        "image3":
            'https://firebasestorage.googleapis.com/v0/b/matrimonial-7e828.appspot.com/o/profile_picture%2FIMG_20200129_180505_860.jpg?alt=media&token=8d0bece3-4abe-43e8-9ac5-8a2c4707866b',
        "Bio Headline": '',
        "Age": '',
        "Gender": ''
      },
    );
  }
  return firebaseUser.user;
}

Future siginwithfacebook(context) async {
  final facebookLoginResult =
      await facebookLogin.logIn(['email', 'public_profile']);
  switch (facebookLoginResult.status) {
    case FacebookLoginStatus.loggedIn:
      print('logged in');
      var firebaseUser = await firebaseAuthWithFacebook(context,
          token: facebookLoginResult.accessToken);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', firebaseUser.email);
      prefs.setString('type', 'facebook');
      return firebaseUser;
      break;
    case FacebookLoginStatus.cancelledByUser:
      print('cancled');
      break;
    case FacebookLoginStatus.error:
      print('error');
      break;
  }
}

Future checkMobile(phonenumber, context) async {
  print(phonenumber);
  fire
      .collection('users')
      .where('Mobile', isEqualTo: phonenumber)
      .getDocuments()
      .then((result) {
    if (result.documents.length > 0) {
      // Navigator.pop(context);
      Fluttertoast.showToast(
          msg: 'OTP has been sent to your registered Mobile Number',
          toastLength: Toast.LENGTH_LONG);
      sendOtp('+91' + phonenumber, context);
    } else {
      print(result.documents);
      Fluttertoast.showToast(
          msg: 'Mobile Number Not Registered', toastLength: Toast.LENGTH_LONG);
    }
  });

  return 'exists';
// if(doc!=null){

// }
}

Future<void> sendOtp(phonenumber, context) async {
  final PhoneCodeAutoRetrievalTimeout autoretrieve = (String verId) {
    verificationCode = verId;
  };
  final PhoneVerificationCompleted verified = (AuthCredential user) {
    print('Verified');
  };
  final PhoneVerificationFailed verifiacationfailed =
      (AuthException exception) {
    Fluttertoast.showToast(
        msg: exception.message, toastLength: Toast.LENGTH_LONG);
    print('${exception.message}');
  };
  final PhoneCodeSent codeSent = (String verId, [int foreceCodeResend]) {
    verificationCode = verId;
    print('code Sent');
    showdialouge(context);
  };
  _auth.verifyPhoneNumber(
      phoneNumber: phonenumber,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verified,
      verificationFailed: verifiacationfailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: autoretrieve);
}

Future showdialouge(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Enter the OTP sent on your mobile',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.all(10),
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(
                    // width: 200,
                    child: TextField(
                  controller: _otp,
                  decoration: InputDecoration(hintText: 'OTP'),
                )),
              ],
            ),
            // Text(
            //     'Enter the OTP sent on your registered mobile number'),
            FlatButton(
              child: Text(
                'Submit',
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                if (verificationCode == _otp.text) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/resetpass');
                } else {
                  Fluttertoast.showToast(
                      msg: 'Entered OTP is Incorrect',
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: Colors.red);
                }
              },
            )
          ],
        );
      });
}

Future updatepass(email, password) async {
  FirebaseUser user = await _auth.currentUser();
  user.updatePassword(password).then((onValue) {
    Fluttertoast.showToast(
        msg: 'Password Updated sucessfully', toastLength: Toast.LENGTH_LONG);
  }).catchError((onError) {
    Fluttertoast.showToast(msg: onError, toastLength: Toast.LENGTH_LONG);
  });
}

_saveDeviceToken(userid) async {
  String fcmtoken = await _fcm.getToken();
  if (fcmtoken != null) {
    var tokens = fire.collection('user_tokens').document(fcmtoken);
    await tokens.setData({
      'token': fcmtoken,
      'createdAt': FieldValue.serverTimestamp(), // optional
      'platform': Platform.operatingSystem,
      'user': userid
    }).then((onValue) {
      // _fcm.subscribeToTopic('notification');
      print('token created');
    });
  }
}

Future createFile(data, userid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  getApplicationDocumentsDirectory().then((Directory directory) {
    dir = directory;
    fileName = userid;
    jsonFile = new File(dir.path + "/" + fileName);
    //print(jsonFile);
    filepath = dir.path + "/" + fileName;
    prefs.setString('file', filepath);
    fileExists = jsonFile.existsSync();
    // if (fileExists) {
    //   LocalStorage()
    //       .writeToFile(data['title'], data['body'], dir, jsonFile, fileName);
    //
    // } else {
    LocalStorage()
        .writeToFile(data['title'], data['body'], dir, jsonFile, fileName);
    fileContent = jsonDecode(jsonFile.readAsStringSync());
    print(fileContent);

    // }
  }).then((onValue) {
    return fileContent.length;
  });
}
