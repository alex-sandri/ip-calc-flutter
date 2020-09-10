import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ip_calc/tabs/ip_address_info.dart';
import 'package:ip_calc/tabs/minimum_subnet_mask.dart';
import 'package:ip_calc/tabs/vlsm.dart';
import 'package:quick_actions/quick_actions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(
      length: 3,
      vsync: this,
    );

    if (Platform.isAndroid || Platform.isIOS)
    {
      final QuickActions quickActions = QuickActions();

      quickActions.initialize((shortcutType) {
        switch (shortcutType)
        {
          case "action_ip_address_info": tabController.index = 0; break;
          case "action_min_subnet_mask": tabController.index = 1; break;
          case "action_vlsm": tabController.index = 2; break;
        }
      });

      quickActions.setShortcutItems([
        const ShortcutItem(type: "action_ip_address_info", localizedTitle: "IP address info", icon: "ic_launcher"),
        const ShortcutItem(type: "action_min_subnet_mask", localizedTitle: "Minimum subnet mask", icon: "ic_launcher"),
        const ShortcutItem(type: "action_vlsm", localizedTitle: "VLSM", icon: "ic_launcher"),
      ]);
    }

    return Material(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "IP Calc",
              ),
              bottom: TabBar(
                controller: tabController,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "IP Address Info",
                  ),
                  Tab(
                    text: "Minimum Subnet Mask",
                  ),
                  Tab(
                    text: "Variable Length Subnet Mask (VLSM)",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                IpAddressInfo(),
                MinimumSubnetMask(),
                Vlsm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}