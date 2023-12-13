

import 'package:flutter/material.dart';
import 'package:sky_stat/Activity/home.dart';
import 'package:sky_stat/Activity/loading.dart';
import 'package:sky_stat/Activity/location.dart';


void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => Loading(),
      "/home": (context) => Home(),
      "/loading": (context) => Loading(),
      "/location": (context) => Location()
    },
  ));
}

