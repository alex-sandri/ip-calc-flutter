class SubnetMask
{
  final String subnetMask;

  SubnetMask(this.subnetMask);

  bool isValid() {
    const String subnetMaskRegExpPart = "(128|192|224|240|248|252|254|255)";

    const String subnetMaskSlashNotationRegExpString = "^/([1-9]|[1-2][0-9]|3[0-1])\$";

    return RegExp("^$subnetMaskRegExpPart\\.$subnetMaskRegExpPart\\.$subnetMaskRegExpPart\\.$subnetMaskRegExpPart\$").hasMatch(this.subnetMask)
      || RegExp(subnetMaskSlashNotationRegExpString).hasMatch(this.subnetMask);
  }
}