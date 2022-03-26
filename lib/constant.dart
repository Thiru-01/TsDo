import 'package:flutter/material.dart';

const MaterialColor primaryColor = MaterialColor(
  0xFF6715B1,
  <int, Color>{
    50: Color.fromRGBO(103, 21, 177, .1),
    100: Color.fromRGBO(103, 21, 177, .2),
    200: Color.fromRGBO(103, 21, 177, .3),
    300: Color.fromRGBO(103, 21, 177, .4),
    400: Color.fromRGBO(103, 21, 177, .5),
    500: Color.fromRGBO(103, 21, 177, .6),
    600: Color.fromRGBO(103, 21, 177, .7),
    700: Color.fromRGBO(103, 21, 177, .8),
    800: Color.fromRGBO(103, 21, 177, .9),
    900: Color.fromRGBO(103, 21, 177, 1),
  },
);

List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
double height(context) {
  return MediaQuery.of(context).size.height;
}

double width(context) {
  return MediaQuery.of(context).size.width;
}

double scalefactor(context) {
  return MediaQuery.of(context).textScaleFactor;
}
