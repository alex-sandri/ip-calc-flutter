import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  CustomFlatButton({
    @required this.text,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        width: double.infinity,
        child: FlatButton(
          child: Text(
            text,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}