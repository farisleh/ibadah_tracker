import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibadah_tracker/model/user.dart';
import 'package:ibadah_tracker/theme/light_colors.dart';

class Collection extends StatefulWidget {
  final UserInformation user;

  Collection({this.user});
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

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
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.luminosity),
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
          ],
        ),
      ),
    );
  }
}
