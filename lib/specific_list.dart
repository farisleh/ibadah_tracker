import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ibadah_tracker/model/user.dart';

// ignore: must_be_immutable
class SpecificView extends StatefulWidget {
  UserInformation user;
  SpecificView({Key key, this.user}) : super(key: key);

  @override
  _SpecificViewState createState() => _SpecificViewState();
}

class _SpecificViewState extends State<SpecificView> {
  List data = [];

  @override
  initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    final response = await http.post(
        Uri.parse("https://ibadah.cahayapath.com/php/specific_ibadah.php"),
        body: {'user_id': widget.user.id});

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Specific Date's Ibadah List"),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: Card(
                  color: Colors.green[200],
                  elevation: 5,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 70.0,
                      child: Row(
                        children: <Widget>[
                          Image(
                              image:
                                  AssetImage("images/${data[index]['image']}")),
                          Container(
                            height: 700,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data[index]['name'],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                    child: Container(
                                      width: 100,
                                      child: Text(
                                        data[index]['percentage'] + '%',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 48, 48, 54)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
    );
  }
}
