import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generation/FrontEnd/MainScreen/MainWindow.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class GoogleAuth {
  final GlobalKey<FormState> _userNameKey = GlobalKey<FormState>();
  TextEditingController _userName = TextEditingController();
  TextEditingController _nickName = TextEditingController();
  TextEditingController _about = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> logIn(BuildContext context) async {
    try {
      if (!await googleSignIn.isSignedIn()) {
        final user = await googleSignIn.signIn();
        if (user == null)
          print("Already Signed In");
        else {
          final GoogleSignInAuthentication googleAuth =
              await user.authentication;

          final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(oAuthCredential);

          DocumentSnapshot responseData = await FirebaseFirestore.instance
              .doc("generation_users/${userCredential.user.email}")
              .get();

          print(responseData.exists);

          if (!responseData.exists) {
            print("Email Not Present");
            await userNameChecking(context, userCredential.user.email);
          } else {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => MainScreen()));

            showAlertBox(context, "Log-In Successful", "Enjoy this app", Colors.green);
          }
        }
      } else {
        print("Already Logged In");
        await logOut();
      }
    } catch (e) {
      print("Google LogIn Error: ${e.toString()}");
      showAlertBox(context, "Log In Error",
          "Log-in not Completed or\nEmail Already Present With Other Credentials", Colors.redAccent);
    }
  }

  Future<bool> logOut() async {
    try {
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
      FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  void showAlertBox(BuildContext context, String _title, String _content, [Color _titleColor = Colors.white]) {
    showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromRGBO(34, 48, 60, 0.5),
              title: Text(
                _title,
                style: TextStyle(color: _titleColor),
              ),
              content: Text(
                _content,
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
            ));
  }

  Future<void> userNameChecking(BuildContext context, String _email) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Color.fromRGBO(34, 48, 60, 1),
              title: Center(
                child: Text(
                  "Set Additional Details",
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ),
              content: Form(
                key: this._userNameKey,
                child: SizedBox(
                  width: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                          controller: _userName,
                          style: TextStyle(color: Colors.white),
                          validator: (inputUserName) {
                            if (inputUserName.length < 6)
                              return "User Name At Least 6 Characters";
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "User Name",
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),

                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                          controller: _nickName,
                          style: TextStyle(color: Colors.white),
                          validator: (inputUserName) {
                            if (inputUserName.length < 6)
                              return "Nick Name At Least 6 Characters";
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Nick Name / Public Friendly Name",
                            labelStyle: TextStyle(color: Colors.white70, fontSize: 14.0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),

                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                          controller: _about,
                          style: TextStyle(color: Colors.white),
                          validator: (inputUserName) {
                            if (inputUserName.length < 6)
                              return "About Should be At Least 6 Characters";
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "About Yourself",
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                          child: Text(
                            "Save",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_userNameKey.currentState.validate()) {
                              print("ok");

                              QuerySnapshot querySnapShot =
                                  await FirebaseFirestore.instance
                                      .collection('generation_users')
                                      .where('user_name',
                                          isEqualTo: this._userName.text)
                                      .get();
                              print(querySnapShot.docs.isEmpty);

                              if (querySnapShot.docs.isEmpty) {
                                FirebaseFirestore.instance
                                    .collection("generation_users")
                                    .doc(_email)
                                    .set({
                                  'user_name': this._userName.text,
                                  'nick_name': this._nickName.text,
                                  'about': this._about.text,
                                  "creation_date": DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now()),
                                  "creation_time":
                                      "${DateFormat('hh:mm a').format(DateTime.now())}",
                                  "connections": {},
                                });

                                print("Log-In Successful: User Name: $_email");

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MainScreen()),
                                    (route) => false);

                                showAlertBox(context, "Log-In Successful",
                                    "Enjoy this app", Colors.green);
                              } else {
                                Navigator.pop(context);
                                showAlertBox(context, "User Name Already Exist",
                                    "Try Another User Name", Colors.yellow);
                              }
                            } else {
                              print("Not Validate");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
