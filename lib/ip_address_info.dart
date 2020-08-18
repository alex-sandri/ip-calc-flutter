import 'package:flutter/material.dart';
import 'package:ip_calc/custom_flat_button.dart';
import 'package:ip_calc/custom_text_field.dart';

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
          CustomTextField(
            label: "IP Address",
            hint: "192.168.1.1",
          ),
          CustomTextField(
            label: "Subnet Mask",
            hint: "255.255.255.0 or /24",
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