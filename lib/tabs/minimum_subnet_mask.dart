import 'package:flutter/material.dart';
import 'package:ip_calc/widgets/custom_flat_button.dart';
import 'package:ip_calc/widgets/custom_text_field.dart';
import 'package:ip_calc/subnet_mask.dart';

class MinimumSubnetMask extends StatelessWidget {
  final TextEditingController _numberOfHostsNeededController = TextEditingController();

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
            controller: _numberOfHostsNeededController,
          ),
          CustomFlatButton(
            text: "Calc",
            onPressed: () {
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
                          "TODO",
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
            onPressed: () => _numberOfHostsNeededController.text = "",
          ),
        ],
      ),
    );
  }
}