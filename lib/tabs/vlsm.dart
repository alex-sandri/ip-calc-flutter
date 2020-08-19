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

  List<TextEditingController> _subnetNameControllers = [];
  List<TextEditingController> _subnetSizeControllers = [];

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
          keyboardType: TextInputType.number,
        ),
        CustomFlatButton(
          text: "Create subnets",
          onPressed: () {
            _subnetNameControllers.clear();
            _subnetSizeControllers.clear();

            for (int i = 0; i < (int.tryParse(_numberOfSubnetsController.text) ?? 0); i++)
            {
              _subnetNameControllers.add(TextEditingController(text: "Subnet$i"));
              _subnetSizeControllers.add(TextEditingController());
            }

            setState(() {});
          },
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: int.tryParse(_numberOfSubnetsController.text) ?? 0,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Subnet name",
                    hint: "Subnet$index",
                    controller: _subnetNameControllers[index],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CustomTextField(
                    label: "Subnet size",
                    hint: "10",
                    controller: _subnetSizeControllers[index],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            );
          },
        ),
        CustomFlatButton(
          text: "Calc",
          onPressed: () {
            print({
              _ipAddressController.text,
              _subnetMaskController.text,
              for (int i = 0; i < _subnetNameControllers.length; i++)
              {
                _subnetNameControllers[i].text,
                _subnetSizeControllers[i].text,
              }
            });
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