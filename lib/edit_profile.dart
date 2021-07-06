import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ibadah_tracker/main.dart';
import 'package:ibadah_tracker/model/user.dart';
import 'package:ibadah_tracker/profile_picture.dart';
import 'package:ibadah_tracker/theme/light_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:csc_picker/csc_picker.dart';

class EditProfile extends StatefulWidget {
  final UserInformation user;

  EditProfile({Key key, this.user}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String countryValue;
  String stateValue;
  String cityValue;
  String profilePic = 'no-image.png';

  @override
  initState() {
    super.initState();
  }

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
                Colors.white.withOpacity(0.3), BlendMode.luminosity),
          ),
        ),
        padding: EdgeInsets.only(left: 0, top: 0, right: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomBar(user: widget.user)),
                      (Route<dynamic> route) => false);
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
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.green[900],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Account",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: Divider(
                height: 15,
                thickness: 2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
                title: const Text(
                  "Change Name",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                trailing: Icon(Icons.edit, color: Colors.green[900]),
                onTap: () {
                  _changeName();
                }),
            ListTile(
                title: const Text(
                  "Change Password",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                trailing: Icon(Icons.edit, color: Colors.green[900]),
                onTap: () {
                  _changePassword();
                }),
            ListTile(
                title: const Text(
                  "Change Profile Picture",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.green[900]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePicture(user: widget.user),
                    ),
                  );
                }),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.green[900],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Location",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: Divider(
                height: 15,
                thickness: 2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: CSCPicker(
                flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                },
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text("Save Location"),
                onPressed: () {
                  _saveLocation();
                },
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _changeName() {
    final TextEditingController _namecontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change " + widget.user.name + " to other's name"),
          content: new TextField(
              keyboardType: TextInputType.text,
              controller: _namecontroller,
              decoration: InputDecoration(
                labelText: 'New name',
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
                child: new Text("Yes"),
                onPressed: () async {
                  if (_namecontroller.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "The field can't be empty",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  EasyLoading.show(
                      status: 'updating...',
                      maskType: EasyLoadingMaskType.black,
                      dismissOnTap: false);
                  await http.post(
                      Uri.parse(
                          "https://ibadah.cahayapath.com/php/update_user.php"),
                      body: {
                        'id': widget.user.id,
                        "name": _namecontroller.text
                      }).then((res) {
                    var string = res.body;
                    List dres = string.split("~");
                    if (dres[0] == "success") {
                      setState(() {
                        widget.user.name = dres[2];
                        EasyLoading.showSuccess('Successfully update!');
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
                    }
                  }).catchError((err) {
                    print(err);
                  });
                }),

            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _changePassword() {
    final TextEditingController _passcontroller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
              "Change password for " + widget.user.name + " to new password"),
          content: new TextField(
              keyboardType: TextInputType.text,
              controller: _passcontroller,
              decoration: InputDecoration(
                labelText: 'New password',
              )),
          actions: <Widget>[
            new FlatButton(
                child: new Text("Yes"),
                onPressed: () async {
                  if (_passcontroller.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "New password can't be empty",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (_passcontroller.text.length < 5) {
                    Fluttertoast.showToast(
                        msg: "Min 5 char required",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  EasyLoading.show(
                      status: 'updating...',
                      maskType: EasyLoadingMaskType.black,
                      dismissOnTap: false);
                  await http.post(
                      Uri.parse(
                          "https://ibadah.cahayapath.com/php/update_password.php"),
                      body: {
                        'id': widget.user.id,
                        "password": _passcontroller.text
                      }).then((res) {
                    EasyLoading.showSuccess('Successfully update!');
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
                  }).catchError((err) {
                    print(err);
                  });
                }),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveLocation() async {
    if (countryValue == null) {
      Fluttertoast.showToast(
          msg: "Country can't be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (stateValue == null) {
      Fluttertoast.showToast(
          msg: "State can't be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (cityValue == null) {
      Fluttertoast.showToast(
          msg: "City can't be empty",
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
        Uri.parse("https://ibadah.cahayapath.com/php/update_location.php"),
        body: {
          "id": widget.user.id,
          "country": countryValue,
          "state": stateValue,
          "city": cityValue
        }).then((res) {
      var string = res.body;
      List dres = string.split("~");
      if (dres[0] == "success") {
        setState(() {
          widget.user.country = dres[15];
          widget.user.state = dres[16];
          widget.user.city = dres[17];
          EasyLoading.showSuccess('Successfully changed!');
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
