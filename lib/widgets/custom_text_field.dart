import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String error;
  final TextEditingController controller;

  CustomTextField({
    @required this.label,
    @required this.hint,
    this.error,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    const _defaultBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: error,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          enabledBorder: _defaultBorderStyle,
          focusedBorder: _defaultBorderStyle,
          errorBorder: _defaultBorderStyle.copyWith(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          focusedErrorBorder: _defaultBorderStyle.copyWith(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}