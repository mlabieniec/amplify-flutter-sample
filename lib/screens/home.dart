import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  AmplifyAuthCognito _auth;
  Home(AmplifyAuthCognito auth) {
    this._auth = auth;
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("Photos"),
              actions: [
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      this._auth.signOut(request: null);
                    })
              ],
              leading: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                  child: Image.asset('assets/amplify.png')),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.photo)),
                  Tab(icon: Icon(Icons.person))
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("Main View"),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("Profile"),
                )
              ],
            )));
  }
}
