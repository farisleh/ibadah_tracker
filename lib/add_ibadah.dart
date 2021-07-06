import 'package:ibadah_tracker/model/user.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibadah_tracker/widgets/back_button.dart';
import 'package:http/http.dart' as http;
import 'package:ibadah_tracker/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// ignore: must_be_immutable
class CreateIbadahPage extends StatefulWidget {
  UserInformation user;

  CreateIbadahPage({Key key, this.user}) : super(key: key);
  @override
  _CreateIbadahPageState createState() => _CreateIbadahPageState();
}

class _CreateIbadahPageState extends State<CreateIbadahPage> {
  String pathAsset = 'no-image.png';
  var myFormat = DateFormat('yyyy-MM-dd');
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _numbercontroller =
      TextEditingController(text: "0");
  final TextEditingController _startdatecontroller = TextEditingController();
  final TextEditingController _enddatecontroller = TextEditingController();
  final FocusNode _fname = FocusNode();
  final FocusNode _fdescription = FocusNode();
  final FocusNode _fnumber = FocusNode();

  DateTime _startdateSpecific = new DateTime.now();
  String _startdateTextSpecific = '';

  Future<Null> _selectStartDateSpecific(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _startdateSpecific,
        firstDate: DateTime(2020),
        lastDate: DateTime(2080));

    if (picked != null) {
      setState(() {
        _startdateSpecific = picked;
        _startdateTextSpecific = "${myFormat.format(_startdateSpecific)}";
      });
    }
  }

  DateTime _enddateSpecific = new DateTime.now();
  String _enddateTextSpecific = '';

  Future<Null> _selectEndDateSpecific(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _enddateSpecific,
        firstDate: DateTime(2020),
        lastDate: DateTime(2080));

    if (picked != null) {
      setState(() {
        _enddateSpecific = picked;
        _enddateTextSpecific = "${myFormat.format(_enddateSpecific)}";
      });
    }
  }

  String typeValue = 'Number';

  final routinesList = ["Daily", "Weekly", "Monthly", "Specific Date"];
  String routinesValue = 'Daily';

  final aimsList = ["Blank", "Count"];
  String aimsValue = 'Blank';

  final countList = [
    "Times",
    "Raka'ah",
    "Pages",
    "Hours",
    "Surah",
    "Money",
    "Others"
  ];
  String countTypeValue = 'Times';

  @override
  initState() {
    _fnumber.addListener(() {
      if (_fnumber.hasFocus) _numbercontroller.clear();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _dateStartDay = new DateTime.now().add(new Duration(days: 0));
    final String dayStartText = myFormat.format(_dateStartDay);
    DateTime _dateEndDay = new DateTime.now().add(new Duration(days: 54750));
    final String dayEndText = myFormat.format(_dateEndDay);
    DateTime _dateStartWeek = new DateTime.now().add(new Duration(days: 0));
    final String weekStartText = myFormat.format(_dateStartWeek);
    DateTime _dateEndWeek = new DateTime.now().add(new Duration(days: 54750));
    final String weekEndText = myFormat.format(_dateEndWeek);
    DateTime _dateStartMonth = new DateTime.now().add(new Duration(days: 0));
    final String monthStartText = myFormat.format(_dateStartMonth);
    DateTime _dateEndMonth = new DateTime.now().add(new Duration(days: 54750));
    final String monthEndText = myFormat.format(_dateEndMonth);
    if (routinesValue == 'Daily') {
      _startdatecontroller.text = dayStartText;
      _enddatecontroller.text = dayEndText;
    }
    if (routinesValue == 'Weekly') {
      _startdatecontroller.text = weekStartText;
      _enddatecontroller.text = weekEndText;
    }
    if (routinesValue == 'Monthly') {
      _startdatecontroller.text = monthStartText;
      _enddatecontroller.text = monthEndText;
    }
    if (routinesValue == 'Specific Date') {
      _startdatecontroller.text = _startdateTextSpecific;
      _enddatecontroller.text = _enddateTextSpecific;
    }
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height / 0.98,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/add1.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: MyBackButton(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create New Ibadah',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 35, 35, 35),
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: _namecontroller,
                        focusNode: _fname,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            labelText: "Ibadah name",
                            labelStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Ibadah aims"),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              style: TextStyle(color: Colors.black87),
                              value: aimsValue,
                              icon: downwardIcon,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 0, 9, 9),
                              ),
                              items: aimsList.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  aimsValue = newValue;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Select Ibadah Type';
                                }
                                return null;
                              },
                            ),
                          ),
                          if (aimsValue == 'Count')
                            Expanded(
                              child: Container(
                                  height: 48,
                                  child: TextField(
                                    controller: _numbercontroller,
                                    focusNode: _fnumber,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.black87),
                                    decoration: InputDecoration(
                                        hintText: "Fill Number",
                                        labelStyle:
                                            TextStyle(color: Colors.black45),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey))),
                                  )),
                            ),
                          if (aimsValue == 'Count')
                            Expanded(
                              child: DropdownButtonFormField(
                                style: TextStyle(color: Colors.black87),
                                value: countTypeValue,
                                icon: downwardIcon,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(0, 0, 9, 9),
                                ),
                                items: countList.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    countTypeValue = newValue;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Select Ibadah Type';
                                  }
                                  return null;
                                },
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Ibadah routine"),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              style: TextStyle(color: Colors.black87),
                              value: routinesValue,
                              icon: downwardIcon,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              items: routinesList.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (String newValue) {
                                setState(() {
                                  routinesValue = newValue;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please Select Ibadah Routine';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (routinesValue == 'Specific Date')
                            Expanded(
                              child: TextField(
                                controller: _startdatecontroller,
                                onTap: () => _selectStartDateSpecific(context),
                                readOnly: true,
                                decoration: new InputDecoration(
                                    labelText: 'From:',
                                    labelStyle: TextStyle(color: Colors.black)),
                                style: new TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                            ),
                          if (routinesValue == 'Specific Date')
                            SizedBox(
                              child: Container(
                                height: 35,
                                width: 40,
                                child: Image(
                                    image: AssetImage("images/calendar.png")),
                              ),
                            ),
                          if (routinesValue == 'Specific Date')
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: TextField(
                                  readOnly: true,
                                  controller: _enddatecontroller,
                                  onTap: () => _selectEndDateSpecific(context),
                                  decoration: new InputDecoration(
                                      labelText: 'To:',
                                      labelStyle:
                                          TextStyle(color: Colors.black)),
                                  style: new TextStyle(
                                      fontSize: 13.0, color: Colors.black),
                                ),
                              ),
                            ),
                        ],
                      ),
                      TextField(
                        controller: _descriptioncontroller,
                        focusNode: _fdescription,
                        textInputAction: TextInputAction.newline,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            labelText: "Description(optional)",
                            labelStyle:
                                TextStyle(fontSize: 14, color: Colors.black54),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                        minLines: 3,
                        maxLines: 3,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Choose icon',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: RawScrollbar(
                            thickness: 4,
                            thumbColor: Colors.green[600],
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              //direction: Axis.vertical,
                              alignment: WrapAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              runSpacing: 5,
                              //textDirection: TextDirection.rtl,
                              spacing: 5.0,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "namaz.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "namaz.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage("images/namaz.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "koran.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "koran.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage("images/koran.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "praying.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "praying.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image:
                                            AssetImage("images/praying.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "muslim.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "muslim.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage("images/muslim.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(
                                      () => pathAsset = "no-drink.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "no-drink.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image:
                                            AssetImage("images/no-drink.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "no-food.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "no-food.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image:
                                            AssetImage("images/no-food.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "mosque.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "mosque.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage("images/mosque.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "kabah.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "kabah.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage("images/kabah.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(
                                      () => pathAsset = "praying-hand.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "praying-hand.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage(
                                            "images/praying-hand.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "hijab.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "hijab.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage("images/hijab.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(
                                      () => pathAsset = "salat-together.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "salat-together.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage(
                                            "images/salat-together.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(
                                      () => pathAsset = "do-not-eat.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "do-not-eat.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage(
                                            "images/do-not-eat.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "charity.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "charity.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image:
                                            AssetImage("images/charity.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(
                                      () => pathAsset = "muslim-prayer.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "muslim-prayer.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage(
                                            "images/muslim-prayer.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "lantern.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "lantern.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image:
                                            AssetImage("images/lantern.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "free.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "free.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage("images/free.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "islamic.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "islamic.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image:
                                            AssetImage("images/islamic.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(
                                      () => pathAsset = "hijab-woman.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "hijab-woman.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage(
                                            "images/hijab-woman.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "eid-day.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "eid-day.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image:
                                            AssetImage("images/eid-day.png")),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => pathAsset = "sujud.png"),
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    color: pathAsset == "sujud.png"
                                        ? Colors.green
                                        : Colors.transparent,
                                    child: Image(
                                        image: AssetImage("images/sujud.png")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: SizedBox(
                              height: 50,
                              width: 300, // specific value
                              child: RaisedButton.icon(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  onPressed: _sendData,
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  icon: Icon(Icons.add),
                                  label: Text(
                                    "Create Ibadah",
                                    style: TextStyle(fontSize: 17),
                                  ))),
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendData() async {
    if (_namecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Ibadah name can't be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (_startdatecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Start date can't be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (_enddatecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "End date can't be empty",
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
        Uri.parse("https://ibadah.cahayapath.com/php/add_ibadah.php"),
        body: {
          "user_id": widget.user.id,
          "name": _namecontroller.text,
          "aims": aimsValue,
          "number": _numbercontroller.text,
          "count_type": countTypeValue,
          "description": _descriptioncontroller.text,
          "routines": routinesValue,
          "start_date": _startdatecontroller.text,
          "end_date": _enddatecontroller.text,
          "image": pathAsset
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
          EasyLoading.showSuccess('Successfully add!');
          EasyLoading.dismiss();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BottomBar(user: widget.user)));
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
