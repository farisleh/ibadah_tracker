import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibadah_tracker/model/user.dart';
import 'package:ibadah_tracker/theme/light_colors.dart';

class QuickTips extends StatefulWidget {
  final UserInformation user;

  QuickTips({this.user});
  @override
  _QuickTipsState createState() => _QuickTipsState();
}

class _QuickTipsState extends State<QuickTips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height / 0.98,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("images/setting.jpeg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: LightColors.kDarkBlue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    spreadRadius: 10,
                    blurRadius: 45,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "IBADAH TRACKER",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "QUICK TIPS",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("CREATE IBADAH",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                            "Create & set your ibadah aim with or without numbers count (optional) - if you do not set your numbers count, your ibadah progress status will show only Achieved or Not Achieved status."),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                            "Set your ibadah routine by daily, weekly, monthly or you can select a specific date - (all routines will auto RESET by chosen routine except for specific date."),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                            "Choose ibadah icon (optional) - icons will be shown at the Dashboard tab."),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("HOW TO TRACK YOUR IBADAH",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                            "Choose your created ibadah at Dashboard tab."),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                            "Update current ibadah status progress (Achieved or Not Achieved) - if Not Achieved, fill up your current count (if you set your ibadah aims)."),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                            "Summary of your Ibadah by IBADAH ROUTINE, will be displayed at the PERFORMANCE tab."),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                            "Here you can track your Ibadah performance (Achieved or Not Achieved) and view the List of IBADAH."),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("SETTING",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                            "Set your location which will allow the ibadah tracker apps to view salah/prayer times."),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.forward,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                            "Edit your profile settings such as name, profile icon, email address, and change your password."),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
