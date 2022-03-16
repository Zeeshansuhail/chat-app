import 'package:chat_app/Screens/auth.dart';
import 'package:chat_app/Screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "chat_app",
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.deepPurpleAccent,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ChatScreen();
              }
              return AuthScreen();
            }));
  }
}
