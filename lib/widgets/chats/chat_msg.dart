import 'package:chat_app/widgets/chats/bubble_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chart')
            .orderBy('createdat', descending: true)
            .snapshots(),
        builder: (context, chatsnopshot) {
          if (chatsnopshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = FirebaseAuth.instance.currentUser;
          final chatdoc = chatsnopshot.data.docs;
          return ListView.builder(
            padding: EdgeInsets.all(10),
            reverse: true,
            itemCount: chatdoc.length,
            itemBuilder: (context, index) => BubbleChat(
              chatdoc[index]['text'],
              chatdoc[index]['username'],
              chatdoc[index]['userid'] == user.uid,
              chatdoc[index]['user_image'],
              chatdoc[index]['createdat'],
              // key: ValueKey(chatdoc[index].documentId),
            ),
          );
        });
  }
}
