import 'package:flutter/material.dart';
import 'package:ibadah_tracker/adhan.dart';
import 'package:ibadah_tracker/collection.dart';
import 'package:ibadah_tracker/edit_profile.dart';
import 'package:ibadah_tracker/login.dart';
import 'package:ibadah_tracker/quick_tips.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'model/user.dart';

// ignore: must_be_immutable
class SettingPage extends StatefulWidget {
  UserInformation user;
  String city;
  final GoogleSignIn googleSignIn;
  Results result;

  SettingPage({Key key, this.user, this.result, this.googleSignIn})
      : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String countryValue;
  String stateValue;
  String cityValue;

  @override
  initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height / 0.98,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("images/profile.jpeg"),
            fit: BoxFit.fill,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Account",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(230, 20, 0, 0),
                    child: GestureDetector(
                        onTap: () {
                          _logout(context);
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ))),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(
                "images/${widget.user.profile}",
              ),
              backgroundColor: Colors.transparent,
              radius: 50.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              widget.user.name,
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              widget.user.email,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white70,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              widget.user.city +
                  ", " +
                  widget.user.state +
                  ", " +
                  widget.user.country +
                  ".",
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.white70,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 40,
                    width: 300, // specific value
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfile(user: widget.user)));
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        icon: Icon(Icons.person_add),
                        label: Text("Edit Profile")))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 40,
                    width: 300, // specific value
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QuickTips(user: widget.user)));
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        icon: Icon(Icons.help),
                        label: Text("Quick Tips")))),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 40,
                    width: 300, // specific value
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Collection(user: widget.user)));
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        icon: Icon(Icons.book),
                        label: Text("Quran & Hadith")))),
          ],
        ),
      ),
    ));
  }

  void _logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', '');
    await prefs.setString('pass', '');
    print("LOGOUT");
    widget.googleSignIn.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
