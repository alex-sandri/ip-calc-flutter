import 'package:flutter/material.dart';
import 'package:ip_calc/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IP Calc",
      theme: ThemeData.dark(),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
