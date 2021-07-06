import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibadah_tracker/edit_profile.dart';
import 'package:ibadah_tracker/model/user.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ProfilePicture extends StatefulWidget {
  final UserInformation user;

  ProfilePicture({this.user});
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  String profilePic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("New Profile Picture"),
      ),
      body: Column(
        children: [
          Container(
            height: 450,
            child: GridView.count(
              crossAxisCount: 3,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 8.0 / 8.0,
              children: <Widget>[
                ClipOval(
                  child: GestureDetector(
                    onTap: () => setState(() => profilePic = "profile2.png"),
                    child: Container(
                      color: profilePic == "profile2.png"
                          ? Colors.green
                          : Colors.transparent,
                      child: Image(
                        image: AssetImage("images/profile2.png"),
                      ),
                    ),
                  ),
                ),
                ClipOval(
                  child: GestureDetector(
                    onTap: () => setState(() => profilePic = "profile1.png"),
                    child: Container(
                      color: profilePic == "profile1.png"
                          ? Colors.green
                          : Colors.transparent,
                      child: Image(image: AssetImage("images/profile1.png")),
                    ),
                  ),
                ),
                ClipOval(
                  child: GestureDetector(
                    onTap: () => setState(() => profilePic = "profile3.png"),
                    child: Container(
                      color: profilePic == "profile3.png"
                          ? Colors.green
                          : Colors.transparent,
                      child: Image(image: AssetImage("images/profile3.png")),
                    ),
                  ),
                ),
                ClipOval(
                  child: GestureDetector(
                    onTap: () => setState(() => profilePic = "profile4.png"),
                    child: Container(
                      color: profilePic == "profile4.png"
                          ? Colors.green
                          : Colors.transparent,
                      child: Image(image: AssetImage("images/profile4.png")),
                    ),
                  ),
                ),
                ClipOval(
                  child: GestureDetector(
                    onTap: () => setState(() => profilePic = "profile5.png"),
                    child: Container(
                      color: profilePic == "profile5.png"
                          ? Colors.green
                          : Colors.transparent,
                      child: Image(image: AssetImage("images/profile5.png")),
                    ),
                  ),
                ),
                ClipOval(
                  child: GestureDetector(
                    onTap: () => setState(() => profilePic = "profile6.png"),
                    child: Container(
                      color: profilePic == "profile6.png"
                          ? Colors.green
                          : Colors.transparent,
                      child: Image(image: AssetImage("images/profile6.png")),
                    ),
                  ),
                ),
                ClipOval(
                  child: GestureDetector(
                    onTap: () => setState(() => profilePic = "profile7.png"),
                    child: Container(
                      color: profilePic == "profile7.png"
                          ? Colors.green
                          : Colors.transparent,
                      child: Image(image: AssetImage("images/profile7.png")),
                    ),
                  ),
                ),
                ClipOval(
                  child: GestureDetector(
                    onTap: () => setState(() => profilePic = "profile8.png"),
                    child: Container(
                      color: profilePic == "profile8.png"
                          ? Colors.green
                          : Colors.transparent,
                      child: Image(image: AssetImage("images/profile8.png")),
                    ),
                  ),
                ),
                ClipOval(
                  child: GestureDetector(
                    onTap: () => setState(() => profilePic = "profile9.png"),
                    child: Container(
                      color: profilePic == "profile9.png"
                          ? Colors.green
                          : Colors.transparent,
                      child: Image(image: AssetImage("images/profile9.png")),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
                height: 50,
                width: 300, // specific value
                child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      _profilePic();
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    icon: Icon(Icons.save),
                    label: Text(
                      "Save Profile Picture",
                      style: TextStyle(fontSize: 17),
                    ))),
          ),
        ],
      ),
    );
  }

  void _profilePic() async {
    if (profilePic == null) {
      Fluttertoast.showToast(
          msg: "Please select profile picture",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black);
    await http.post(
        Uri.parse("https://ibadah.cahayapath.com/php/update_picture.php"),
        body: {"id": widget.user.id, "profile": profilePic}).then((res) {
      var string = res.body;
      List dres = string.split("~");
      if (dres[0] == "success") {
        setState(() {
          widget.user.profile = dres[18];
          EasyLoading.showSuccess('Profile Picture Changed!');
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfile(
                  user: widget.user,
                ),
              ),
              (Route<dynamic> route) => false);
          return;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((err) {
      print(err);
    });
  }
}
