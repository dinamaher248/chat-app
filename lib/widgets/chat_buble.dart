import 'package:chat_app/models/messages.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class ChatBuble extends StatelessWidget {
   ChatBuble({super.key,required this.message});
 final Messages message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: PrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          message.messages,
          style: TextStyle(color: TextColor),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
   ChatBubleForFriend({required this.message});
 final Messages message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: friendMessgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          message.messages,
          style: TextStyle(color: TextColor),
        ),
      ),
    );
  }
}
