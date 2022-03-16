import 'package:chat_app/widgets/chats/chat_msg.dart';
import 'package:chat_app/widgets/chats/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.pink,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text("Logout"),
                    ],
                  ),
                ),
                value: "logout",
              ),
            ],
            onChanged: (itemidenfier) {
              if (itemidenfier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ChatsMessages(),
            ),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
