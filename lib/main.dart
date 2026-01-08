import 'package:flutter/material.dart';
import 'package:flutter_time/pages/choose_location.dart';
import 'package:flutter_time/pages/home.dart';
import 'package:flutter_time/pages/loading.dart';
import 'package:flutter_time/pages/welcome.dart';
import 'package:flutter_time/pages/map.dart';
import 'package:flutter_time/pages/zoom.dart';

void main() {
  runApp(MaterialApp(
    // home: Home(),
    initialRoute: '/load',
    routes: {
      '/load':(context) => Loading(),
      '/home':(context) => Home(),
      '/location':(context) => ChooseLocation(),
      '/welcome':(context) => Welcome(),
      '/map':(context) => Map(),
      '/zoom':(context) => Zoom()

    },
  ));
}


