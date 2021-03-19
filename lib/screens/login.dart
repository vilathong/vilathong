
import 'package:final_project/screens/register.dart';
import 'package:final_project/utility/dialog.dart';
import 'package:final_project/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double screen;
  bool _securetext = true;
  String email, password;

  Widget buidlLogo() => Container(
        width: screen * 0.5,
        child: Mystyle().showLogo(),
      );

  Widget typeEmail() => Container(
        width: screen * 0.8,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            labelText: 'Email',
            icon: Icon(
              Icons.email,
              color: Mystyle().darkColor,
              size: 27.0,
            ),
            labelStyle: TextStyle(
              color: Mystyle().darkColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            fillColor: Mystyle().darkColor,
          ),
          maxLength: 80,
        ),
      );

  Widget typePassword() => Container(
        width: screen * 0.8,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Mystyle().darkColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            icon: Icon(
              Icons.vpn_key,
              color: Mystyle().darkColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  _securetext = !_securetext;
                });
              },
            ),
          ),
          obscureText: _securetext,
        ),
      );

  Widget loginButton() => Container(
        width: 300.0,
        child: RaisedButton(
          child: Text(
            'Log In',
            style: TextStyle(color: Colors.white),
          ),
          color: Mystyle().darkColor,
          onPressed: () {
            if ((email?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
              normalDialog(context, 'Please Type Information');
            } else {
              checkAuthen();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );

  Widget textRegister() => Container(
        child: Text(
          'Do You Have An Account?',
          style: TextStyle(
            decoration: TextDecoration.combine([TextDecoration.underline]),
            fontSize: 17.0,
            color: Mystyle().primaryColor,
          ),
        ),
      );

  Widget registerButton() => Container(
        width: 300.0,
        child: RaisedButton(
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
          color: Mystyle().darkColor,
          onPressed: () {
            Navigator.pop(context);
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => Register());
            Navigator.push(context, route);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );

  Widget textOther() => Container(
        child: Text(
          'Other',
          style: TextStyle(
            color: Mystyle().darkColor,
            fontSize: 17.0,
            decoration: TextDecoration.combine([TextDecoration.underline]),
          ),
        ),
      );

  Widget forgetpasswordButton() => Container(
        width: 300.0,
        child: RaisedButton(
          child: Text(
            'Forget Password',
            style: TextStyle(color: Colors.white),
          ),
          color: Mystyle().darkColor,
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mystyle().lightColor,
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app_rounded), onPressed: () {})
        ],
        title: Text('Log In Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buidlLogo(),
              typeEmail(),
              Mystyle().showBox(),
              typePassword(),
              SizedBox(
                height: 10.0,
              ),
              loginButton(),
              Mystyle().showBox(),
              textRegister(),
              Mystyle().showBox(),
              registerButton(),
              Mystyle().showBox(),
              textOther(),
              Mystyle().showBox(),
              forgetpasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false))
          .catchError((value) => normalDialog(context, value.message));
    });
  }
}
