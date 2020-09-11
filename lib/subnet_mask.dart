import 'dart:math';

enum SubnetMaskNotation
{
  DOT_DECIMAL,
  SLASH,
}

class SubnetMask
{
  final String subnetMask;

  SubnetMask(this.subnetMask)
  {
    if (!isValid()) throw ArgumentError("Invalid subnet mask");
  }

  bool isValid() {
    return
      RegExp(
        "^"
        + "(128|192|224|240|248|252|254|255)"
        + "\\."
        + "(0|128|192|224|240|248|252|254|255)"
        + "\\."
        + "(0|128|192|224|240|248|252|254|255)"
        + "\\."
        + "(0|128|192|224|240|248|252|254|255)"
        + "\$"
      ).hasMatch(this.subnetMask)
      || RegExp("^/([1-9]|[1-2][0-9]|3[0-1])\$").hasMatch(this.subnetMask);
  }

  SubnetMask convertTo(SubnetMaskNotation notation) {
    String subnetMask;

    SubnetMaskNotation fromNotation = this.subnetMask.startsWith("/")
      ? SubnetMaskNotation.SLASH
      : SubnetMaskNotation.DOT_DECIMAL;

    if (fromNotation == notation) return this;

    if (notation == SubnetMaskNotation.SLASH)
    {
      subnetMask = "/"
        + this
            .convertTo(SubnetMaskNotation.DOT_DECIMAL)
            .subnetMask
            .split(".")
            .map(int.parse)
            .reduce((value, element) => value + element.toRadixString(2).replaceAll("0", "").length)
            .toString();
    }
    else
    {
      String dotDecimalSubnetMask = "";
			int subnetMaskBits = this.getBitCount();

			for (int i = 0; i < 4; i++)
			{
				dotDecimalSubnetMask += "${subnetMaskBits >= 8 ? "255" : int.parse(("1" * subnetMaskBits).padRight(8, "0"), radix: 2)}.";

				subnetMaskBits -= min(subnetMaskBits, 8);
			}

			subnetMask = dotDecimalSubnetMask.substring(0, dotDecimalSubnetMask.length - 1);
    }

    return SubnetMask(subnetMask);
  }

  int getBitCount() => int.parse(this.convertTo(SubnetMaskNotation.SLASH).subnetMask.replaceFirst("/", ""));

  int getMaxNumberOfHosts() => pow(2, 32 - this.getBitCount()) - 2;

  static SubnetMask getMinimum(int hosts) {
    hosts += 2; // Network and Broadcast addresses

    int bitsNeeded = 1;

    while (pow(2, bitsNeeded) < hosts) bitsNeeded++;

    if (32 - bitsNeeded <= 0)
      throw ArgumentError("Too many hosts");

    return SubnetMask("/${32 - bitsNeeded}");
  }
}