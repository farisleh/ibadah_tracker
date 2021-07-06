import 'package:flutter/material.dart';
import 'package:ibadah_tracker/login.dart';
import 'package:ibadah_tracker/main.dart';
import 'package:ibadah_tracker/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

String _email, _password;
String urlLogin = "https://ibadah.cahayapath.com/php/login.php";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/2.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/splashnew.png',
                  scale: 2,
                ),
                SizedBox(
                  height: 20,
                ),
                new ProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.value > 0.99) {
            //print('Sucess Login');
            loadpref(this.context);
          }
        });
      });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
      width: 200,
      color: Colors.green,
    ));
  }

  Map<int, Color> color = {
    50: Color.fromRGBO(255, 0, 0, .1),
    100: Color.fromRGBO(255, 0, 0, .2),
    200: Color.fromRGBO(255, 0, 0, .3),
    300: Color.fromRGBO(255, 0, 0, .4),
    400: Color.fromRGBO(255, 0, 0, .5),
    500: Color.fromRGBO(255, 0, 0, .6),
    600: Color.fromRGBO(255, 0, 0, .7),
    700: Color.fromRGBO(255, 0, 0, .8),
    800: Color.fromRGBO(255, 0, 0, .9),
    900: Color.fromRGBO(255, 0, 0, 1),
  };

  void loadpref(BuildContext ctx) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email') ?? '');
    _password = (prefs.getString('password') ?? '');
    if (_isEmailValid(_email ?? "no email")) {
      _onLogin(_email, _password, ctx);
    } else {
      Navigator.push(
          ctx, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void _onLogin(String email, String password, BuildContext ctx) {
    http.post(Uri.parse(urlLogin), body: {
      "email": _email,
      "password": _password,
    }).then((res) {
      var string = res.body;
      List dres = string.split("~");
      print(dres);
      if (dres[0] == "success") {
        UserInformation user = new UserInformation(
            id: dres[1],
            name: dres[2],
            email: dres[3],
            daily: dres[4],
            weekly: dres[5],
            monthly: dres[6],
            daily_achieve: dres[7],
            daily_not_achieve: dres[8],
            weekly_achieve: dres[9],
            weekly_not_achieve: dres[10],
            monthly_achieve: dres[11],
            monthly_not_achieve: dres[12],
            specific_achieve: dres[13],
            specific_not_achieve: dres[14],
            country: dres[15],
            state: dres[16],
            city: dres[17],
            profile: dres[18]);

        Navigator.push(ctx,
            MaterialPageRoute(builder: (context) => BottomBar(user: user)));
      } else {
        Navigator.push(
            ctx, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    }).catchError((err) {
      print(err);
    });
  }
}
