import 'package:flutter/material.dart';
import '../components/signIn.dart';
import '../components/signUp.dart';

class Authenticator extends StatefulWidget {
  Authenticator({Key key}) : super(key: key);

  @override
  AuthenticatorState createState() => AuthenticatorState();
}

class AuthenticatorState extends State<Authenticator> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("AWS Amplify"),
              leading: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset('assets/amplify.png')),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person_add_outlined)),
                  Tab(icon: Icon(Icons.person_outline))
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SignUp(),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SignIn(),
                )
              ],
            )));
  }
}
