import 'package:flutter/material.dart';

class IpAddress
{
  final String address;
  final SubnetMask subnetMask;

  IpAddress({
    @required this.address,
    this.subnetMask,
  });
}