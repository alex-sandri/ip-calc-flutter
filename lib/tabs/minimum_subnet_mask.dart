import 'package:flutter/material.dart';
import 'package:ip_calc/widgets/custom_flat_button.dart';
import 'package:ip_calc/widgets/custom_text_field.dart';
import 'package:ip_calc/models/SubnetMask.dart';

class MinimumSubnetMask extends StatefulWidget {
  @override
  _MinimumSubnetMaskState createState() => _MinimumSubnetMaskState();
}

class _MinimumSubnetMaskState extends State<MinimumSubnetMask> {
  final TextEditingController _numberOfHostsNeededController = TextEditingController();

  String _numberOfHostsNeededError;

  final List<ListTile> _result = [];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        CustomTextField(
          label: "Number of hosts needed",
          hint: "254",
          error: _numberOfHostsNeededError,
          controller: _numberOfHostsNeededController,
          keyboardType: TextInputType.number,
        ),
        CustomFlatButton(
          text: "Calc",
          onPressed: () {
            SubnetMask subnetMask;

            _result.clear();

            try
            {
              if (int.tryParse(_numberOfHostsNeededController.text) == null || int.parse(_numberOfHostsNeededController.text) < 0)
                throw ArgumentError("Invalid number of hosts");

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

            _result.add(ListTile(
              title: SelectableText("Subnet mask"),
              subtitle: SelectableText(
                "${subnetMask.convertTo(SubnetMaskNotation.DOT_DECIMAL).subnetMask} (${subnetMask.convertTo(SubnetMaskNotation.SLASH).subnetMask})"
              ),
            ));
          },
        ),
        CustomFlatButton(
          text: "Reset",
          onPressed: () {
            _numberOfHostsNeededController.text = "";

            _result.clear();

            setState(() {
              _numberOfHostsNeededError = null;
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