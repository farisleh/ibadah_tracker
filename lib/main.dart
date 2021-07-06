import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibadah_tracker/performance.dart';
import 'package:ibadah_tracker/model/user.dart';
import 'package:ibadah_tracker/setting.dart';
import 'home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  UserInformation user;
  final GoogleSignIn googleSignIn;

  BottomBar({Key key, this.user, this.googleSignIn}) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> tabs;
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      MyHomePage(user: widget.user),
      PerformancePage(user: widget.user),
      SettingPage(
        user: widget.user,
        googleSignIn: googleSignIn,
      ),
    ];
  }

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
        body: tabs[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Dashboard"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              title: Text("Performance"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
