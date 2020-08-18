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
}