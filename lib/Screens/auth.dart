import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/auth/auth_data.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final firebase = FirebaseAuth.instance;
  void _userdata(String email, String username, String password, bool islogin,
      BuildContext ctx, File pickedimage) async {
    UserCredential authResult;
    try {
      if (islogin) {
        authResult = await firebase.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await firebase.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child("user_image")
            .child(authResult.user.uid + 'jpg');

        await ref.putFile(pickedimage);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({'email': email, 'username': username, 'image_url': url});
      }
    } on PlatformException catch (error) {
      String Message = '';

      if (error.message != null) {
        Message = error.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString().trim()),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(_userdata);
  }
}
