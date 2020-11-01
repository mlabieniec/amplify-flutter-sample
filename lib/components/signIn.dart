import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'dart:developer' as dev;

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  //String _signUpError = "";
  //List<String> _signUpExceptions = [];

  void _signIn() async {
    try {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Signing in...')));
      SignInResult res = await Amplify.Auth.signIn(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim());
      dev.log('Sign In Result: ' + res.toString(),
          name: 'com.amazonaws.amplify');
    } on AuthError catch (e) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(e.exceptionList[1].detail)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Sign in to Your Account',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
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
                ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _signIn();
                          }
                        },
                        child: Text('SIGN IN'),
                      ),
                    )),
              ],
            )));
  }
}
