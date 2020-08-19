import 'package:flutter/material.dart';
import 'package:ip_calc/ip_address.dart';
import 'package:ip_calc/subnet_mask.dart';
import 'package:ip_calc/widgets/custom_flat_button.dart';
import 'package:ip_calc/widgets/custom_text_field.dart';

class VlsmResult
{
  final String name;
  final int size;
  final int maxNumOfHosts;
  final SubnetMask subnetMask;
  final IpAddress firstUsableHostAddress;
  final IpAddress lastUsableHostAddress;
  final IpAddress networkAddress;
  final IpAddress broadcastAddress;

  VlsmResult({
    @required this.name,
    @required this.size,
    @required this.maxNumOfHosts,
    @required this.subnetMask,
    @required this.firstUsableHostAddress,
    @required this.lastUsableHostAddress,
    @required this.networkAddress,
    @required this.broadcastAddress,
  });
}

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

  List<VlsmResult> _result = [];

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

            try
            {
              if (int.tryParse(_numberOfSubnetsController.text) == null) throw ArgumentError("Invalid number of subnets");

              _numberOfSubnetsError = null;
            }
            catch (e)
            {
              if (e is ArgumentError)
                _numberOfSubnetsError = e.message;
            }

            if (_numberOfSubnetsError == null)
            {
              for (int i = 0; i < int.parse(_numberOfSubnetsController.text); i++)
              {
                _subnetNameControllers.add(TextEditingController(text: "Subnet$i"));
                _subnetSizeControllers.add(TextEditingController());
              }
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
            IpAddress ipAddress;
            SubnetMask subnetMask;
            int numberOfSubnets;

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

            try
            {
              if ((numberOfSubnets = int.tryParse(_numberOfSubnetsController.text)) == null) throw ArgumentError("Invalid number of subnets");

              _numberOfSubnetsError = null;
            }
            catch (e)
            {
              if (e is ArgumentError)
                _numberOfSubnetsError = e.message;
            }

            setState(() {});

            // TODO: Validate subnet name and size inputs

            if (_ipAddressError != null || _subnetMaskError != null || _numberOfSubnetsError != null) return;

            IpAddress tempIpAddress = ipAddress;

            for (int i = 0; i < numberOfSubnets; i++)
            {
              final int subnetSize = int.parse(_subnetSizeControllers[i].text);
              final SubnetMask minimumSubnetMask = SubnetMask(SubnetMask.getMinimum(subnetSize).subnetMask);

              tempIpAddress = IpAddress(
                address: tempIpAddress.address,
                subnetMask: minimumSubnetMask,
              );

              final int maxNumOfHosts = minimumSubnetMask.getMaxNumberOfHosts();
              final IpAddress networkAddress = tempIpAddress.getNetworkAddress();

              _result.add(VlsmResult(
                name: _subnetNameControllers[i].text,
                size: subnetSize,
                maxNumOfHosts: maxNumOfHosts,
                subnetMask: minimumSubnetMask,
                firstUsableHostAddress: tempIpAddress.getFirstUsableHostAddress(),
                lastUsableHostAddress: tempIpAddress.getLastUsableHostAddress(),
                networkAddress: networkAddress,
                broadcastAddress: tempIpAddress.getBroadcastAddress(),
              ));
            }

            setState(() {});
          },
        ),
        CustomFlatButton(
          text: "Reset",
          onPressed: () {
            _ipAddressController.text = _subnetMaskController.text = _numberOfSubnetsController.text = "";

            _result.clear();

            setState(() {
              _ipAddressError = _subnetMaskError = _numberOfSubnetsError = null;
            });
          },
        ),

        if (_result.length > 0)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    "Subnet name"
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Needed size"
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Allocated size"
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Subnet mask"
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Network address"
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Assignable range"
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Broadcast address"
                  ),
                ),
              ],
              rows: [
                for (int i = 0; i < _result.length; i++)
                  DataRow(
                    cells: [
                      DataCell(Text(_result[i].name)),
                      DataCell(Text(_result[i].size.toString())),
                      DataCell(Text(_result[i].maxNumOfHosts.toString())),
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                      DataCell(Text("")),
                    ],
                  ),
              ],
            ),
          ),
      ],
    );
  }
}