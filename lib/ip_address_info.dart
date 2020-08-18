import 'package:flutter/material.dart';
import 'package:ip_calc/custom_flat_button.dart';
import 'package:ip_calc/custom_text_field.dart';

class IpAddressInfo extends StatefulWidget {
  @override
  _IpAddressInfoState createState() => _IpAddressInfoState();
}

class _IpAddressInfoState extends State<IpAddressInfo> {
  String _ipAddressError;
  String _subnetMaskError;

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
          CustomTextField(
            label: "IP Address",
            hint: "192.168.1.1",
            error: _ipAddressError,
          ),
          CustomTextField(
            label: "Subnet Mask",
            hint: "255.255.255.0 or /24",
            error: _subnetMaskError,
          ),
          CustomFlatButton(
            text: "Calc",
            onPressed: () {
              // TODO
            },
          ),
          CustomFlatButton(
            text: "Reset",
            onPressed: () {
              // TODO
            },
          ),
        ],
      ),
    );
  }
}