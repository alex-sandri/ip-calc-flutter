import 'package:flutter/material.dart';
import 'package:ip_calc/subnet_mask.dart';

class IpAddress
{
  final String address;
  final SubnetMask subnetMask;

  IpAddress({
    @required this.address,
    this.subnetMask,
  });

  bool isValid() {
    const String ipv4RegExpPart = "([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])";

    return RegExp("^$ipv4RegExpPart\\.$ipv4RegExpPart\\.$ipv4RegExpPart\\.$ipv4RegExpPart\$").hasMatch(this.address);
  }
}