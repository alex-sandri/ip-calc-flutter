import 'package:flutter/material.dart';
import 'package:ip_calc/ip_address_info.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "IP Calc",
          ),
        ),
        body: ListView(
          children: [
            IpAddressInfo(),
          ],
        ),
      ),
    );
  }
}