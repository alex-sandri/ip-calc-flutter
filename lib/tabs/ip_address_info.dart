import 'package:flutter/material.dart';
import 'package:ip_calc/widgets/custom_flat_button.dart';
import 'package:ip_calc/widgets/custom_text_field.dart';
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

  final List<ListTile> _result = [];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        CustomTextField(
          label: "IP address",
          hint: "192.168.1.1",
          error: _ipAddressError,
          controller: _ipAddressController,
        ),
        CustomTextField(
          label: "Subnet mask",
          hint: "255.255.255.0 or /24",
          error: _subnetMaskError,
          controller: _subnetMaskController,
        ),
        CustomFlatButton(
          text: "Calc",
          onPressed: () {
            IpAddress ipAddress;
            SubnetMask subnetMask;

            try
            {
              subnetMask = SubnetMask(_subnetMaskController.text);

              _subnetMaskError = null;
            }
            catch (e)
            {
              if (e is ArgumentError)
                _subnetMaskError = e.message;
            }

            try
            {
              ipAddress = IpAddress(
                address: _ipAddressController.text,
                subnetMask: subnetMask,
              );

              _ipAddressError = null;
            }
            catch (e)
            {
              if (e is ArgumentError)
                _ipAddressError = e.message;
            }

            setState(() {});

            if (_ipAddressError != null || _subnetMaskError != null) return;

            _result.add(ListTile(
              title: SelectableText("Network address"),
              subtitle: SelectableText(ipAddress.getNetworkAddress().address),
            ));
            
            _result.add(ListTile(
              title: SelectableText("Broadcast address"),
              subtitle: SelectableText(ipAddress.getBroadcastAddress().address),
            ));

            _result.add(ListTile(
              title: SelectableText("Maximum number of hosts"),
              subtitle: SelectableText(ipAddress.subnetMask.getMaxNumberOfHosts().toString()),
            ));

            _result.add(ListTile(
              title: SelectableText("Private"),
              subtitle: SelectableText(ipAddress.isPrivate().toString()),
            ));
          },
        ),
        CustomFlatButton(
          text: "Reset",
          onPressed: () {
            _ipAddressController.text = _subnetMaskController.text = "";

            setState(() {
              _ipAddressError = _subnetMaskError = null;
            });
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _result.length,
          itemBuilder: (context, index) => _result[index],
        ),
      ],
    );
  }
}