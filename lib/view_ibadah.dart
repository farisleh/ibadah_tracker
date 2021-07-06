import 'package:ibadah_tracker/model/user.dart';
import 'package:ibadah_tracker/theme/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ibadah_tracker/main.dart';

// ignore: must_be_immutable
class ViewIbadah extends StatefulWidget {
  UserInformation user;
  String id,
      name,
      aims,
      number,
      userInput,
      countType,
      routines,
      description,
      startDate,
      endDate,
      image,
      percentage,
      status;

  ViewIbadah(
      {Key key,
      this.user,
      this.id,
      this.name,
      this.aims,
      this.number,
      this.userInput,
      this.countType,
      this.routines,
      this.description,
      this.startDate,
      this.endDate,
      this.image,
      this.percentage,
      this.status})
      : super(key: key);
  @override
  _ViewIbadahState createState() => _ViewIbadahState();
}

class _ViewIbadahState extends State<ViewIbadah> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height / 0.98,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/viewibadah.jpeg"),
            fit: BoxFit.fill,
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
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomBar(user: widget.user)),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(285, 20, 0, 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 25.0,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      deleteLeave();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Your Ibadah Progress",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 140,
              padding: const EdgeInsets.only(left: 120, right: 120),
              child: LiquidCircularProgressIndicator(
                value: int.parse(widget.percentage) / 100,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                backgroundColor: Colors.white,
                borderColor: Colors.green,
                borderWidth: 2,
                direction: Axis.vertical,
                center: Text(
                  widget.percentage.toString() + "%",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: AspectRatio(
                      aspectRatio: 6.0 / 8.0,
                      child:
                          Image(image: AssetImage("images/performance.png"))),
                ),
                trailing: ButtonTheme(
                  minWidth: 70.0,
                  height: 30.0,
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      _button();
                    },
                    child: Text("Update"),
                  ),
                ),
                title: const Text("Current progress"),
                subtitle: Text(widget.userInput +
                    " / " +
                    widget.number +
                    " " +
                    widget.countType),
                onTap: () => print("ListTile")),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: AspectRatio(
                  aspectRatio: 6.0 / 8.0,
                  child: Image(image: AssetImage("images/${widget.image}")),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 25.0,
                  color: Colors.green,
                ),
                onPressed: () {
                  _changeName();
                },
              ),
              title: const Text("Ibadah name"),
              subtitle: Text(widget.name),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: AspectRatio(
                    aspectRatio: 6.0 / 8.0,
                    child: Image(image: AssetImage("images/calendar.png"))),
              ),
              title: const Text("Date created"),
              subtitle: Text(widget.startDate),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: AspectRatio(
                    aspectRatio: 6.0 / 8.0,
                    child: Image(image: AssetImage("images/des.png"))),
              ),
              title: const Text("Description"),
              subtitle: Text(widget.description),
              isThreeLine: true,
            ),
          ],
        ),
      ),
    ));
  }

  void _changeName() {
    final TextEditingController _namecontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change " + widget.name + " to other's ibadah name"),
          content: new TextField(
              keyboardType: TextInputType.text,
              maxLines: 2,
              controller: _namecontroller,
              decoration: InputDecoration(
                labelText: 'Ibadah name',
                icon: AspectRatio(
                  aspectRatio: 1.0 / 14.0,
                  child: Image(image: AssetImage("images/${widget.image}")),
                ),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
                child: new Text("Yes"),
                onPressed: () async {
                  if (_namecontroller.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "The field can't be empty",
                        toastLength: Toast.LENGTH_SHORT,
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
                          "https://ibadah.cahayapath.com/php/update_ibadah.php"),
                      body: {
                        'id': widget.id,
                        "name": _namecontroller.text,
                        "number": widget.number
                      }).then((res) {
                    EasyLoading.showSuccess('Successfully update!');
                    EasyLoading.dismiss();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewIbadah(
                            user: widget.user,
                            id: widget.id,
                            name: _namecontroller.text,
                            aims: widget.aims,
                            number: widget.number,
                            userInput: widget.userInput,
                            countType: widget.countType,
                            description: widget.description,
                            startDate: widget.startDate,
                            endDate: widget.endDate,
                            image: widget.image,
                            status: widget.status,
                            percentage: widget.percentage,
                          ),
                        ),
                        (Route<dynamic> route) => false);
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

  void _button() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("How your ibadah progress?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
                child: new Text("Achieve"),
                onPressed: () {
                  _updateNumberAchieved();
                }),

            new FlatButton(
              child: new Text(
                "Not Achieve",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _updateNumber();
              },
            ),
            new FlatButton(
              child: new Text("Cancel", style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateNumber() {
    final TextEditingController _numbercontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Update your current ibadah aims"),
          content: new TextField(
              keyboardType: TextInputType.number,
              controller: _numbercontroller,
              decoration: InputDecoration(
                labelText: 'Fill number',
                icon: Icon(Icons.shutter_speed),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
                child: new Text("Yes"),
                onPressed: () async {
                  if (_numbercontroller.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "The field can't be empty",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (int.parse(_numbercontroller.text) >
                      int.parse(widget.number)) {
                    Fluttertoast.showToast(
                        msg: "Can't be more than number aim's achievement",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  if (int.parse(widget.percentage) == 100) {
                    Fluttertoast.showToast(
                        msg: "You have achieved this ibadah",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  EasyLoading.show(
                      status: 'Updating...',
                      maskType: EasyLoadingMaskType.black,
                      dismissOnTap: false);
                  await http.post(
                      Uri.parse(
                          "https://ibadah.cahayapath.com/php/update_ibadah.php"),
                      body: {
                        'id': widget.id,
                        'user_id': widget.user.id,
                        "user_input": _numbercontroller.text,
                        "number": widget.number,
                        "routines": widget.routines,
                      }).then((res) {
                    var string = res.body;
                    List dres = string.split("~");
                    if (dres[0] == "success") {
                      setState(() {
                        widget.user.daily = dres[4];
                        widget.user.weekly = dres[5];
                        widget.user.monthly = dres[6];
                        widget.user.daily_achieve = dres[7];
                        widget.user.daily_not_achieve = dres[8];
                        widget.user.weekly_achieve = dres[9];
                        widget.user.weekly_not_achieve = dres[10];
                        widget.user.monthly_achieve = dres[11];
                        widget.user.monthly_not_achieve = dres[12];
                        widget.user.specific_achieve = dres[13];
                        widget.user.specific_not_achieve = dres[14];
                        EasyLoading.showSuccess('Successfully update!');
                        EasyLoading.dismiss();
                        int a = int.parse(_numbercontroller.text);
                        int b = int.parse(widget.number);
                        double c = a / b;
                        int d = (c * 100).toInt();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewIbadah(
                                  user: widget.user,
                                  id: widget.id,
                                  name: widget.name,
                                  aims: widget.aims,
                                  number: widget.number,
                                  userInput: _numbercontroller.text,
                                  countType: widget.countType,
                                  routines: widget.routines,
                                  description: widget.description,
                                  startDate: widget.startDate,
                                  endDate: widget.endDate,
                                  image: widget.image,
                                  status: widget.status,
                                  percentage: d.toString()),
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

  void _updateNumberAchieved() {
    if (int.parse(widget.percentage) == 100) {
      Fluttertoast.showToast(
          msg: "You have achieved this ibadah",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    EasyLoading.show(
        status: 'Updating...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);
    http.post(
        Uri.parse(
            "https://ibadah.cahayapath.com/php/update_ibadah_achieved.php"),
        body: {
          'id': widget.id,
          'user_id': widget.user.id,
          "number": widget.number,
          "user_input": widget.number,
          "routines": widget.routines,
          "percentage": widget.percentage
        }).then((res) {
      var string = res.body;
      List dres = string.split("~");
      if (dres[0] == "success") {
        setState(() {
          widget.user.daily = dres[4];
          widget.user.weekly = dres[5];
          widget.user.monthly = dres[6];
          widget.user.daily_achieve = dres[7];
          widget.user.daily_not_achieve = dres[8];
          widget.user.weekly_achieve = dres[9];
          widget.user.weekly_not_achieve = dres[10];
          widget.user.monthly_achieve = dres[11];
          widget.user.monthly_not_achieve = dres[12];
          widget.user.specific_achieve = dres[13];
          widget.user.specific_not_achieve = dres[14];
          EasyLoading.showSuccess('Successfully update!');
          EasyLoading.dismiss();

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ViewIbadah(
                    user: widget.user,
                    id: widget.id,
                    name: widget.name,
                    aims: widget.aims,
                    number: widget.number,
                    userInput: widget.number,
                    countType: widget.countType,
                    routines: widget.routines,
                    description: widget.description,
                    startDate: widget.startDate,
                    endDate: widget.endDate,
                    image: widget.image,
                    status: widget.status,
                    percentage: 100.toString()),
              ),
              (Route<dynamic> route) => false);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void deleteLeave() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Ready to delete?"),
          content: new Text("This ibadah will delete."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                updateDelete();
              },
            ),
            new FlatButton(
              child: new Text("No", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void updateDelete() async {
    EasyLoading.show(
        status: 'Deleting...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);
    await http.post(
        Uri.parse("https://ibadah.cahayapath.com/php/delete_ibadah.php"),
        body: {
          'id': widget.id,
          'routines': widget.routines,
          'percentage': widget.percentage,
          'user_id': widget.user.id,
          "number": widget.number,
          "user_input": widget.number
        }).then((res) {
      var string = res.body;
      List dres = string.split("~");
      if (dres[0] == "success") {
        setState(() {
          widget.user.daily = dres[4];
          widget.user.weekly = dres[5];
          widget.user.monthly = dres[6];
          widget.user.daily_achieve = dres[7];
          widget.user.daily_not_achieve = dres[8];
          widget.user.weekly_achieve = dres[9];
          widget.user.weekly_not_achieve = dres[10];
          widget.user.monthly_achieve = dres[11];
          widget.user.monthly_not_achieve = dres[12];
          widget.user.specific_achieve = dres[13];
          widget.user.specific_not_achieve = dres[14];
          EasyLoading.showSuccess('Successfully delete!');
          EasyLoading.dismiss();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomBar(user: widget.user)));
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
