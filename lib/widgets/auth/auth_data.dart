import 'dart:io';

import '../auth/image_show.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.authdata);

  final void Function(String email, String username, String password,
      bool login, BuildContext context, File image) authdata;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  String _emailaddress;
  String _username;
  String _password;
  bool _login = true;
  BuildContext ctx;
  File imagefile;
  void _pickedimage(File image) {
    imagefile = image;
  }

  void _trysumbit() {
    FocusScope.of(context).unfocus();

    print(imagefile.toString());
    if (imagefile == null && !_login) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).accentColor,
          content: Text("Please picked image")));
      return;
    }
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
    }
    widget.authdata(
        _emailaddress, _username, _password, _login, context, imagefile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_login) ImageShow(_pickedimage),
                    TextFormField(
                      key: ValueKey("email"),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                      ),
                      validator: (value) {
                        if (value.isEmpty || !value.contains("@")) {
                          return "check your email address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _emailaddress = value;
                      },
                    ),
                    if (!_login)
                      TextFormField(
                        key: ValueKey("username"),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Username",
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return "check your username";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey("password"),
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return "check your password";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RaisedButton(
                        child: Text(
                          _login ? "Login" : "signup",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _trysumbit();
                        }),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _login = !_login;
                        });
                      },
                      child: Text(
                        _login ? "Create a account" : "Already account",
                        style: TextStyle(color: Colors.pink),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
