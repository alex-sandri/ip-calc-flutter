import 'package:flutter/material.dart';
import 'package:ip_calc/models/SubnetMask.dart';

class IpAddress
{
  final String address;
  final SubnetMask subnetMask;

  IpAddress({
    @required this.address,
    this.subnetMask,
  })
  {
    if (!isValid()) throw ArgumentError("Invalid IP address");
  }

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
      networkAddress += "${int.parse(networkAddressBits.substring(i * 8, (i * 8) + 8), radix: 2)}.";

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
      broadcastAddress += "${int.parse(broadcastAddressBits.substring(i * 8, (i * 8) + 8), radix: 2)}.";

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

  IpAddress getFirstUsableHostAddress()
  {
    String addressInBits = getNetworkAddress().getInBits();

    addressInBits = (addressInBits.substring(0, addressInBits.lastIndexOf("0")) + "1");

    String firstUsableHostAddress = "";

    for (int i = 0; i < 4; i++)
      firstUsableHostAddress += "${int.parse(addressInBits.substring(i * 8, (i * 8) + 8), radix: 2)}.";

    return IpAddress(
      address: firstUsableHostAddress.substring(0, firstUsableHostAddress.length - 1),
      subnetMask: subnetMask,
    );
  }

  IpAddress getLastUsableHostAddress()
  {
    String addressInBits = getBroadcastAddress().getInBits();

    addressInBits = (addressInBits.substring(0, addressInBits.lastIndexOf("1")) + "0");

    String lastUsableHostAddress = "";

    for (int i = 0; i < 4; i++)
      lastUsableHostAddress += "${int.parse(addressInBits.substring(i * 8, (i * 8) + 8), radix: 2)}.";

    return IpAddress(
      address: lastUsableHostAddress.substring(0, lastUsableHostAddress.length - 1),
      subnetMask: subnetMask,
    );
  }

  IpAddress getNthAddress(int offset)
  {
    List<int> addressParts = this.address.split(".").map(int.parse).toList();

    int remainder = offset;

    for (int i = 0; remainder > 0 && i < 4; i++)
    {
      addressParts[3 - i] += remainder;

      if (addressParts[3 - i] > 255)
      {
        remainder = (addressParts[3 - i] / 255).truncate();

        addressParts[3 - i] = addressParts[3 - i] % 255;
      }
      else remainder = 0;
    }

    String address = addressParts.join(".");

    return IpAddress(
      address: address,
      subnetMask: subnetMask,
    );
  }

  bool isIncludedInSubnet({ @required SubnetMask subnetMask, @required IpAddress networkAddress })
  {
    String addressBits = getInBits();
    String networkAddressBits = networkAddress.getInBits();
        
    int subnetMaskBitCount = networkAddress.subnetMask.getBitCount();

    return addressBits.substring(0, subnetMaskBitCount) == networkAddressBits.substring(0, subnetMaskBitCount);
  }

  bool isPrivate()
  {
    return
      isIncludedInSubnet(
        subnetMask: subnetMask, 
        networkAddress: IpAddress(address: "10.0.0.0", subnetMask: SubnetMask("/8"))
      )
      || isIncludedInSubnet(
          subnetMask: subnetMask, 
          networkAddress: IpAddress(address: "172.16.0.0", subnetMask: SubnetMask("/12"))
        )
      || isIncludedInSubnet(
          subnetMask: subnetMask,
          networkAddress: IpAddress(address: "192.168.0.0", subnetMask: SubnetMask("/16"))
        );
  }
}