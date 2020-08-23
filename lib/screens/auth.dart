import 'package:flutter/material.dart';
import '../components/signIn.dart';
import '../components/signUp.dart';
import '../components/forgotPassword.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class Authenticator extends StatelessWidget {
  Authenticator(AmplifyAuthCognito auth) {
    auth?.events?.listenToAuth((hubEvent) {
      switch (hubEvent["eventName"]) {
        case "SIGNED_IN":
          {
            print("USER IS SIGNED IN");
          }
          break;
        case "SIGNED_OUT":
          {
            print("USER IS SIGNED OUT");
          }
          break;
        case "SESSION_EXPIRED":
          {
            print("USER IS SIGNED IN");
          }
          break;
        default:
          {
            print("CONFIGURATION EVENT");
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Photos"),
              leading: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                  child: Image.asset('assets/amplify.png')),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person_add_outlined)),
                  Tab(icon: Icon(Icons.login)),
                  Tab(icon: Icon(Icons.person_search_outlined))
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
