import 'package:flutter/material.dart';
import 'package:ip_calc/ip_address_info.dart';
import 'package:ip_calc/minimum_subnet_mask.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "IP Calc",
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.info_outline),
                    text: "IP Address Info",
                  ),
                  Tab(
                    text: "Minimum Subnet Mask",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                IpAddressInfo(),
                MinimumSubnetMask(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}