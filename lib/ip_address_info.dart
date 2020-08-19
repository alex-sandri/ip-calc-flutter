import 'package:flutter/material.dart';
import 'package:ip_calc/custom_flat_button.dart';
import 'package:ip_calc/custom_text_field.dart';
import 'package:ip_calc/ip_address.dart';
import 'package:ip_calc/subnet_mask.dart';

class IpAddressInfo extends StatefulWidget {
  @override
  _IpAddressInfoState createState() => _IpAddressInfoState();
}

class _IpAddressInfoState extends State<IpAddressInfo> {
  String _ipAddressError;
  String _subnetMaskError;

  final TextEditingController _ipAddressController = TextEditingController();
  final TextEditingController _subnetMaskController = TextEditingController();

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
            controller: _ipAddressController,
          ),
          CustomTextField(
            label: "Subnet Mask",
            hint: "255.255.255.0 or /24",
            error: _subnetMaskError,
            controller: _subnetMaskController,
          ),
          CustomFlatButton(
            text: "Calc",
            onPressed: () {
              final IpAddress ipAddress = IpAddress(
                address: _ipAddressController.text,
                subnetMask: SubnetMask(
                  _subnetMaskController.text,
                ),
              );

              print({
                ipAddress.getNetworkAddress().address,
                ipAddress.getBroadcastAddress().address,
                ipAddress.subnetMask.getMaxNumberOfHosts(),
                ipAddress.isPrivate(),
              });
            },
          ),
          CustomFlatButton(
            text: "Reset",
            onPressed: () => _ipAddressController.text = _subnetMaskController.text = "",
          ),
        ],
      ),
    );
  }
}