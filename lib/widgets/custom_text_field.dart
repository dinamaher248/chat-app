import 'package:flutter/material.dart';

import '../constant/colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.hintText,
    this.isObscure = false,
    this.onChanged,
  });
  String hintText;
  bool? isObscure;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      obscureText: isObscure!,
      cursorColor: TextColor,
      decoration: InputDecoration(
        // hintText: hintText,
        // hintStyle: TextStyle(color: TextColor),
        labelText: hintText,
        labelStyle: TextStyle(color: TextColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: TextColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: TextColor),
        ),
        border: OutlineInputBorder(borderSide: BorderSide(color: TextColor)),
      ),
    );
  }
}
