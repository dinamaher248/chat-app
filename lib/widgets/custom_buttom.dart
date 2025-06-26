import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
   CustomButtom({required this.text,required this.onTap});
  String text;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: TextColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: CustomText(
            color: PrimaryColor,
            fontSize: 30,
            fontWeight: FontWeight.w200,
            text: text,
          ),
        ),
      ),
    );
  }
}
