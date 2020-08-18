import 'package:flutter/material.dart';

class IpAddressInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "IP Address Info",
            style: Theme.of(context).textTheme.headline5,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "IP Address",
              hintText: "192.168.1.1",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Subnet Mask",
              hintText: "255.255.255.0 or /24"
            ),
          ),
          FlatButton(
            onPressed: () {
              // TODO
            },
            child: Text(
              "Calc",
            ),
          ),
          FlatButton(
            onPressed: () {
              // TODO
            },
            child: Text(
              "Reset",
            ),
          ),
        ],
      ),
    );
  }
}