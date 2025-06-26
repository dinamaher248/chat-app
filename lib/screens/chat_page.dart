import 'package:chat_app/constant/api_constant.dart';
import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/constant/image_pathes.dart';
import 'package:chat_app/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/chat_buble.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollections,
  );

  TextEditingController controller = TextEditingController();

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Messages> messageList = [];
    //var email = ModalRoute.of(context)!.settings.arguments;//this if using normal pushNamed
    final email = GoRouterState.of(context).extra as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          messageList.clear();
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            final data = snapshot.data!.docs[i].data() as Map<String, dynamic>;
            messageList.add(Messages.fromJson(data));
          }

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,

              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImagePathes.logo, width: 50, height: 50),
                  Text(
                    "Chat",
                    style: TextStyle(color: TextColor, fontSize: 25),
                  ),
                ],
              ),
              backgroundColor: PrimaryColor,
            ),

            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBuble(message: messageList[index])
                          : ChatBubleForFriend(message: messageList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      fillColor: TextColor,
                      focusColor: PrimaryColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          final text = controller.text.trim();
                          if (text.isNotEmpty) {
                            messages.add({
                              kMessage: text,
                              kCreatedAt: DateTime.now(),
                              'id': email,
                            });
                            controller.clear();
                            _controller.animateTo(
                              0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                            FocusScope.of(
                              context,
                            ).unfocus(); // يقفل الكيبورد بعد الإرسال
                          }
                        },
                        icon: Icon(Icons.send, color: PrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(body: Center(child: Text('Loading...')));
        }
      },
    );
  }
}
