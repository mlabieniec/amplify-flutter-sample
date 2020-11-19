import 'package:flutter/material.dart';
import '../components/signIn.dart';
import '../components/signUp.dart';
import '../components/forgotPassword.dart';

class Authenticator extends StatelessWidget {
  Authenticator() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Amplify"),
              leading: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                  child: Image.asset('assets/amplify.png')),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person_add)),
                  Tab(icon: Icon(Icons.person)),
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
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ForgotPassword(),
                )
              ],
            )));
  }
}
