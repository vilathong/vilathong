import 'package:final_project/screens/login.dart';
import 'package:final_project/utility/dialog.dart';
import 'package:final_project/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screen;
  bool _securetext = true;
  String user, email, password;

  Widget buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      width: screen * 0.75,
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Mystyle().lightColor),
          hintText: 'Type User :',
          prefixIcon: Icon(
            Icons.people_alt_outlined,
            color: Mystyle().darkColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Mystyle().darkColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Mystyle().lightColor,
            ),
          ),
        ),
        onChanged: (value) => user = value.trim(),
        maxLength: 80,
      ),
    );
  }

  Widget buildEmail() => Container(
        margin: EdgeInsets.only(top: 16.0),
        width: screen * 0.75,
        child: TextField(
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Mystyle().lightColor),
            hintText: 'Type Email',
            prefixIcon: Icon(
              Icons.email_sharp,
              color: Mystyle().lightColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Mystyle().lightColor),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Mystyle().lightColor)),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => email = value.trim(),
          maxLength: 80,
        ),
      );

  Widget userPassword() => Container(
        margin: EdgeInsets.only(top: 16.0),
        width: screen * 0.75,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Type Password',
            hintStyle: TextStyle(
              color: Mystyle().lightColor,
            ),
            prefixIcon: Icon(
              Icons.vpn_key_outlined,
              color: Mystyle().lightColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  _securetext = !_securetext;
                });
              },
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Mystyle().lightColor),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Mystyle().lightColor,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onChanged: (value) => password = value.trim(),
          obscureText: _securetext,
        ),
      );

  Widget confrimPassword() => Container(
        margin: EdgeInsets.only(top: 16.0),
        width: screen * 0.75,
        child: TextField(
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Mystyle().lightColor),
            hintText: 'Confrim Password',
            prefixIcon: Icon(
              Icons.vpn_key_sharp,
              color: Mystyle().lightColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
              ),
              onPressed: () {
                setState(() {
                  _securetext = !_securetext;
                });
              },
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Mystyle().lightColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Mystyle().lightColor),
            ),
          ),
          onChanged: (value) => password = value.trim(),
          obscureText: _securetext,
        ),
      );

  Widget buildLogo() => Container(
        width: screen * 0.5,
        child: Mystyle().showLogo(),
      );

  Widget registerButton() => Container(
        width: 300.0,
        child: RaisedButton(
          child: Text(
            'Register',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Mystyle().primaryColor,
          onPressed: () {
            print('user = $user,email = $email, password = $password');
            if ((user?.isEmpty ?? true) ||
                (email?.isEmpty ?? true) ||
                (password?.isEmpty ?? true)) {
              print('Please Type your Info');
              normalDialog(context, 'Please Type Your Info');
            } else {
              print('Null');
              registerFirebase();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
        ),
      );

  Future<Null> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print('## Register Success ##');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print('Register Success');
        await value.user.updateProfile(displayName: user).then((value) =>
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false));
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    print('screen= $screen');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mystyle().primaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);}),
        ],
        title: Text('Register Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(),
              buildUser(),
              buildEmail(),
              userPassword(),
              confrimPassword(),
              Mystyle().showBox(),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }
}
