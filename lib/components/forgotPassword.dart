import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'dart:developer' as dev;

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  void _forgotPass() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Forgot Password',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: "Enter your Username"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Username';
                    }
                    return null;
                  },
                ),
                ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            _forgotPass();
                          }
                        },
                        child: Text('SUBMIT'),
                      ),
                    )),
              ],
            )));
  }
}
