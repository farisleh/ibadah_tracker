import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibadah_tracker/main.dart';
import 'package:ibadah_tracker/model/user.dart';
import 'package:ibadah_tracker/register.dart';
import 'package:ibadah_tracker/utilities/constants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String urlLogin = "https://ibadah.cahayapath.com/php/login.php";
  String urlUpload = "https://ibadah.cahayapath.com/php/register_google.php";
  final TextEditingController emcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  String email = '';
  String password = "";
  bool _rememberMe = false;
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isSignIn = false;
  User _user;

  Future<User> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await firebaseauth.signInWithCredential(credential);
    User firebaseUser = authResult.user;
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    print("signed in " + firebaseUser.displayName);
    EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);

    http.post(Uri.parse(urlUpload), body: {
      "name": firebaseUser.displayName.toString(),
      "email": firebaseUser.email.toString(),
      "password": randomNumber.toString()
    }).then((res) {
      print(res.statusCode);
      var string = res.body;
      List dres = string.split("~");
      print(dres);
      if (dres[0] == "success") {
        EasyLoading.showSuccess('Login Success!');
        EasyLoading.dismiss();
        print(dres);
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

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BottomBar(user: user, googleSignIn: googleSignIn)));
      } else {
        EasyLoading.showError('Login failed');
        EasyLoading.dismiss();
      }
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emcontroller,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passcontroller,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (bool value) {
                _onChange(value);
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          _onTappedLogin();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => _signIn(),
            AssetImage(
              'images/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => RegisterScreen()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/2.jpeg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _buildEmailTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        _buildForgotPasswordBtn(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                        _buildSignInWithText(),
                        _buildSocialBtnRow(),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTappedLogin() {
    email = emcontroller.text;
    password = passcontroller.text;

    if (email.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email can't be empty",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Password can't be empty",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (password.length < 5) {
      Fluttertoast.showToast(
          msg: "Min 5 password char required",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (_isEmailValid(email) && (password.length >= 5)) {
      EasyLoading.show(
          status: 'loading...',
          maskType: EasyLoadingMaskType.black,
          dismissOnTap: false);

      http.post(Uri.parse(urlLogin), body: {
        "email": email,
        "password": password,
      }).then((res) {
        print(res.statusCode);
        var string = res.body;
        List dres = string.split("~");
        print(dres);
        if (dres[0] == "success") {
          EasyLoading.showSuccess('Login Success!');
          EasyLoading.dismiss();
          print(dres);
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

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BottomBar(user: user)));
        } else {
          EasyLoading.showError('Login failed');
          EasyLoading.dismiss();
        }
      }).catchError((err) {
        EasyLoading.dismiss();
        print(err);
      });
    }
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
      savepref(value);
    });
  }

  void savepref(bool value) async {
    email = emcontroller.text;
    password = passcontroller.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      if (_isEmailValid(email) && (password.length >= 5)) {
        await prefs.setString('email', email);
        await prefs.setString('password', password);
        print('Save pref $email');
        print('Save pref $password');
        Fluttertoast.showToast(
            msg: "Preferences has been saved",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        setState(() {
          _rememberMe = false;
        });
        Fluttertoast.showToast(
            msg: "Your email or password is invalid",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      setState(() {
        emcontroller.text = '';
        passcontroller.text = '';
        _rememberMe = false;
      });
      Fluttertoast.showToast(
          msg: "Preferences has been removed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
}
