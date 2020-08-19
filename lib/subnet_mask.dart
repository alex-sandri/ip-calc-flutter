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
    const String subnetMaskRegExpPart = "(128|192|224|240|248|252|254|255)";

    const String subnetMaskSlashNotationRegExpString = "^/([1-9]|[1-2][0-9]|3[0-1])\$";

    return RegExp("^$subnetMaskRegExpPart\\.$subnetMaskRegExpPart\\.$subnetMaskRegExpPart\\.$subnetMaskRegExpPart\$").hasMatch(this.subnetMask)
      || RegExp(subnetMaskSlashNotationRegExpString).hasMatch(this.subnetMask);
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

    int power = 1;

    while (power < hosts) power *= 2;

    return SubnetMask("/${log(power) / ln2}");
  }
}