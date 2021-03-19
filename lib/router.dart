import 'package:final_project/home.dart';
import 'package:final_project/screens/login.dart';
import 'package:final_project/screens/register.dart';
import 'package:flutter/material.dart';

  final Map<String, WidgetBuilder> routes = {
    '/home' : (BuildContext context) => Home(),
    '/login' : (BuildContext context) => Login(),
    '/register' : (BuildContext context) => Register(),
  };