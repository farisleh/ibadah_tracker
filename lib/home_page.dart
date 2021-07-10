import 'dart:convert' show Encoding, json, jsonDecode;
import 'package:analog_clock/analog_clock.dart';
import 'package:ibadah_tracker/add_ibadah.dart';
import 'package:ibadah_tracker/model/adhan.dart';
import 'package:ibadah_tracker/model/user.dart';
import 'package:flutter/material.dart';
import 'package:ibadah_tracker/view_ibadah.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  final UserInformation user;

  MyHomePage({Key key, this.user}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Adhan adhanList;
  List data = [];
  String urlGetIbadah = "https://ibadah.cahayapath.com/php/get_ibadah.php";
  GlobalKey<RefreshIndicatorState> refreshKey;
  String hadith = 'Narrated Umar bin Al-Khattab' +
      '\n' +
      'I heard Allah' +
      "'s" +
      ' Messenger (ﷺ) saying,"The reward of deeds depends upon the intentions and every person will get the reward according to what he has intended. So whoever emigrated for worldly benefits or for a woman to marry, his emigration was for what he emigrated for."';

  Future fetchData() async {
    final response = await http.post(Uri.parse(urlGetIbadah),
        body: {'user_id': widget.user.id},
        encoding: Encoding.getByName("utf-8"));

    return json.decode(response.body);
  }

  @override
  initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getPTData();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('d MMMM yyyy');
    final String formatted = formatter.format(now);
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        color: Colors.green,
        onRefresh: () async {
          await refreshList();
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/2.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          height: MediaQuery.of(context).size.height / 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/masjid.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment(-0.94, -0.3),
                            child: Container(
                                height: 110.0,
                                width: 120.0,
                                child: AnalogClock(
                                  isLive: true,
                                  hourHandColor: Colors.black,
                                  minuteHandColor: Colors.black,
                                  showSecondHand: true,
                                  numberColor: Colors.transparent,
                                  tickColor: Colors.white,
                                  showNumbers: true,
                                  textScaleFactor: 2.4,
                                  showTicks: true,
                                  showDigitalClock: true,
                                  digitalClockColor: Colors.white,
                                  datetime: DateTime.now(),
                                )),
                          ),
                          Align(
                              alignment: Alignment(-0.84, 0.55),
                              child: Container(
                                  child: Text(
                                formatted.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ))),
                          FutureBuilder(
                              future: getPTData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                      child: Marquee(
                                    text: "Today's time prayer in " +
                                        widget.user.city +
                                        ",  " +
                                        "Fajr  " +
                                        snapshot.data.data.timings.fajr +
                                        ",  " +
                                        "Dhuhr  " +
                                        snapshot.data.data.timings.dhuhr +
                                        ",  " +
                                        "Asr  " +
                                        snapshot.data.data.timings.asr +
                                        ",  " +
                                        "Maghrib  " +
                                        snapshot.data.data.timings.maghrib +
                                        ",  " +
                                        "Isha  " +
                                        snapshot.data.data.timings.isha,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[600]),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    blankSpace: 20.0,
                                    velocity: 80.0,
                                    showFadingOnlyWhenScrolling: false,
                                    fadingEdgeStartFraction: 0.2,
                                    fadingEdgeEndFraction: 0.2,
                                    startPadding: 10.0,
                                    accelerationDuration: Duration(seconds: 5),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration:
                                        Duration(milliseconds: 5000),
                                    decelerationCurve: Curves.easeOut,
                                  ));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ])),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      title: Text(
                        "Today's Ibadah",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      trailing: ClipOval(
                        child: Material(
                          color: Colors.green,
                          child: InkWell(
                            splashColor: Colors.lightGreen,
                            child: SizedBox(
                                width: 46, height: 46, child: Icon(Icons.add)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CreateIbadahPage(user: widget.user)));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: RawScrollbar(
                        thickness: 4,
                        thumbColor: Colors.green[600],
                        child: FutureBuilder(
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) print(snapshot.error);
                              return snapshot.hasData
                                  ? GridView.builder(
                                      addAutomaticKeepAlives: true,
                                      physics: ScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 8 / 10.0,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      primary: true,
                                      padding: EdgeInsets.all(10.0),
                                      itemBuilder: (context, index) {
                                        List list = snapshot.data;
                                        return Container(
                                          child: RawMaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewIbadah(
                                                    user: widget.user,
                                                    id: list[index]['id'],
                                                    name: list[index]['name'],
                                                    aims: list[index]['aims'],
                                                    number: list[index]
                                                        ['number'],
                                                    userInput: list[index]
                                                        ['user_input'],
                                                    countType: list[index]
                                                        ['count_type'],
                                                    routines: list[index]
                                                        ['routines'],
                                                    description: list[index]
                                                        ['description'],
                                                    startDate: list[index]
                                                        ['start_date'],
                                                    endDate: list[index]
                                                        ['end_date'],
                                                    image: list[index]['image'],
                                                    status: list[index]
                                                        ['status'],
                                                    percentage: list[index]
                                                        ['percentage'],
                                                  ),
                                                ),
                                              );
                                            },
                                            elevation: 10,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  AspectRatio(
                                                    aspectRatio: 20.0 / 8.0,
                                                    child: Image(
                                                        image: AssetImage(
                                                            "images/${list[index]['image']}")),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            16.0,
                                                            12.0,
                                                            16.0,
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Center(
                                                          child: Text(
                                                            list[index]['name'],
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    );
                            }))),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/lantern-islamic.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Center(
                      child: Container(
                    margin: EdgeInsets.only(
                        left: 25, top: 30, right: 25, bottom: 20),
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
                    child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20.0),
                        children: [
                          Center(
                            child: Text(
                              "Sahih al-Bukhari",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              hadith,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future makeRequest() async {
    final response = await http
        .post(Uri.parse(urlGetIbadah), body: {'user_id': widget.user.id});

    return json.decode(response.body);
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    this.makeRequest();
    return null;
  }

  Future getPTData() async {
    http.Response res = await http.get(
        Uri.parse(
            "http://api.aladhan.com/v1/timingsByCity?city=${widget.user.city}&country=${widget.user.country}&method=11&&tune=10,10,-1,2,4,1,-8,1,74"),
        headers: {
          "Accept":
              "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
        });

    final pt = jsonDecode(res.body);
    adhanList = Adhan.fromJson(pt);
    return adhanList;
  }
}
