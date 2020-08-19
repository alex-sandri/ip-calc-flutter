import 'package:flutter/material.dart';
import 'package:ip_calc/widgets/custom_flat_button.dart';
import 'package:ip_calc/widgets/custom_text_field.dart';

class Vlsm extends StatefulWidget {
  @override
  _VlsmState createState() => _VlsmState();
}

class _VlsmState extends State<Vlsm> {
  final TextEditingController _ipAddressController = TextEditingController();
  final TextEditingController _subnetMaskController = TextEditingController();
  final TextEditingController _numberOfSubnetsController = TextEditingController();

  String _ipAddressError;
  String _subnetMaskError;
  String _numberOfSubnetsError;

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
        CustomTextField(
          label: "Number of subnets",
          hint: "4",
          error: _numberOfSubnetsError,
          controller: _numberOfSubnetsController,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: int.tryParse(_numberOfSubnetsController.text) ?? 0,
          itemBuilder: (context, index) {
            final TextEditingController subnetNameController = TextEditingController(text: "Subnet$index");

            return Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Subnet name",
                    hint: "Subnet$index",
                    controller: subnetNameController,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CustomTextField(
                    label: "Subnet size",
                    hint: "10",
                  ),
                ),
              ],
            );
          },
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
            _ipAddressController.text = _subnetMaskController.text = _numberOfSubnetsController.text = "";

            setState(() {
              _ipAddressError = _subnetMaskError = _numberOfSubnetsError = null;
            });
          },
        ),
      ],
    );
  }
}