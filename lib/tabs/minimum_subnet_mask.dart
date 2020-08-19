import 'package:flutter/material.dart';
import 'package:ip_calc/widgets/custom_flat_button.dart';
import 'package:ip_calc/widgets/custom_text_field.dart';
import 'package:ip_calc/subnet_mask.dart';

class MinimumSubnetMask extends StatefulWidget {
  @override
  _MinimumSubnetMaskState createState() => _MinimumSubnetMaskState();
}

class _MinimumSubnetMaskState extends State<MinimumSubnetMask> {
  final TextEditingController _numberOfHostsNeededController = TextEditingController();

  String _numberOfHostsNeededError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: "Number of hosts needed",
            hint: "254",
            error: _numberOfHostsNeededError,
            controller: _numberOfHostsNeededController,
          ),
          CustomFlatButton(
            text: "Calc",
            onPressed: () {
              SubnetMask subnetMask;

              try
              {
                if (int.tryParse(_numberOfHostsNeededController.text) == null) throw ArgumentError("Invalid number of hosts");

                subnetMask = SubnetMask.getMinimum(int.parse(_numberOfHostsNeededController.text));

                _numberOfHostsNeededError = null;
              }
              catch (e)
              {
                if (e is ArgumentError)
                  _numberOfHostsNeededError = e.message;
              }

              setState(() {});

              if (_numberOfHostsNeededError != null) return;

              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          "Subnet mask",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SelectableText(
                          "${subnetMask.convertTo(SubnetMaskNotation.DOT_DECIMAL).subnetMask} (${subnetMask.convertTo(SubnetMaskNotation.SLASH).subnetMask})",
                          style: TextStyle(
                            fontWeight: FontWeight.w100
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          CustomFlatButton(
            text: "Reset",
            onPressed: () {
              _numberOfHostsNeededController.text = "";

              setState(() {
                _numberOfHostsNeededError = null;
              });
            },
          ),
        ],
      ),
    );
  }
}