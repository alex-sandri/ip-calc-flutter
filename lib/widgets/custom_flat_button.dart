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
    return Container(
      width: double.infinity,
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        onPressed: onPressed,
        color: Colors.white,
        splashColor: Colors.grey.shade400,
      ),
    );
  }
}