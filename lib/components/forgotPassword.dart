import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _confirmController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isReset = false;

  void _forgotPass() async {
    try {
      ResetPasswordResult res = await Amplify.Auth.resetPassword(
          username: _usernameController.text.trim());
      print(res);
      setState(() {
        _isReset = true;
      });
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Please enter the confirmation code that was sent")));
    } on AuthException catch (e) {
      print(e.message);
      setState(() {
        _isReset = false;
      });
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _confirmForgotPass() async {
    try {
      await Amplify.Auth.confirmPassword(
          username: _usernameController.text.trim(),
          newPassword: _passwordController.text.trim(),
          confirmationCode: _confirmController.text.trim());
      setState(() {
        _isReset = false;
      });
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Your password has been reset.")));
    } on AuthException catch (e) {
      print(e.message);
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Reset failed, please check your confirmation code.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Visibility(
                    visible: _isReset,
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Enter Confirmation Code',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24))),
                      TextFormField(
                        controller: _confirmController,
                        decoration: InputDecoration(
                            hintText: 'Enter Confirmation Code'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a Confirmation Code';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            InputDecoration(hintText: 'Enter a New Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a password';
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
                                  _confirmForgotPass();
                                }
                              },
                              child: Text('SUBMIT'),
                            ),
                          )),
                    ])),
                Visibility(
                    visible: !_isReset,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Forgot Password',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 24)),
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration:
                            InputDecoration(hintText: "Enter your Username"),
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
                                if (_formKey.currentState.validate()) {
                                  _forgotPass();
                                }
                              },
                              child: Text('SUBMIT'),
                            ),
                          )),
                    ]))
              ],
            )));
  }
}
