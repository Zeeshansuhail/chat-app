import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key key}) : super(key: key);

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var newmessages = "";
  final _textcontroller = new TextEditingController();

  void sendmessage() async {
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser;
    final name = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chart').add({
      'text': newmessages,
      'createdat': Timestamp.now(),
      'userid': user.uid,
      'username': name['username'],
      'user_image': name['image_url']
    });
    _textcontroller.clear();
    setState(() {
      newmessages = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextField(
                controller: _textcontroller,
                decoration: new InputDecoration(
                    labelText: "Type a Message.....",
                    fillColor: Colors.grey.shade100,
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: BorderSide()),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    filled: true),
                onChanged: (value) {
                  setState(() {
                    newmessages = value;
                  });
                },
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 25,
                    offset: const Offset(5, 10),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: newmessages.trim().isEmpty
                  ? null
                  : () {
                      sendmessage();
                    },
              icon: newmessages.isEmpty
                  ? Icon(Icons.settings_voice_rounded)
                  : Icon(Icons.send))
        ],
      ),
    );
  }
}
