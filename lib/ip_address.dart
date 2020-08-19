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

  IpAddress getNetworkAddress() {
    String networkAddress = "";
    String networkAddressBits
      = getInBits()
          .substring(0, subnetMask.getBitCount())
          .padRight(32, "0");

    for (int i = 0; i < 4; i++)
      networkAddress += "${int.parse(networkAddressBits.substring(i * 8, 8), radix: 2)}.";

    return IpAddress(
      address: networkAddress.substring(0, networkAddress.length - 1),
      subnetMask: subnetMask,
    );
  }

  IpAddress getBroadcastAddress() {
    String broadcastAddress = "";
    String broadcastAddressBits
      = getInBits()
          .substring(0, subnetMask.getBitCount())
          .padRight(32, "1");

    for (int i = 0; i < 4; i++)
      broadcastAddress += "${int.parse(broadcastAddressBits.substring(i * 8, 8), radix: 2)}.";

    return IpAddress(
      address: broadcastAddress.substring(0, broadcastAddress.length - 1),
      subnetMask: subnetMask,
    );
  }

  String getInBits([ bool dotSeparated = false ]) =>
    address
    .split(".")
    .map((num) => int.parse(num).toRadixString(2).padLeft(8, "0"))
    .join(dotSeparated ? "." : "");
}