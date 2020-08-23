import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'dart:developer' as dev;

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _verifyPasswordController = TextEditingController();

  void _signUp() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Create a New Account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: "Enter a Username"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Enter your Email"),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter an Email Address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: "Enter a Password"),
                  obscureText: true,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a Password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _verifyPasswordController,
                  decoration: InputDecoration(hintText: "Verify Password"),
                  obscureText: true,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please verify password';
                    }
                    if (value.contains(_passwordController.text.trim())) {
                      return null;
                    } else {
                      return 'Passwords do not match';
                    }
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
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('SIGN UP'),
                      ),
                    )),
              ],
            )));
  }
}
