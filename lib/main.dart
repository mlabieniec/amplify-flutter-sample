import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';
import 'screens/auth.dart';
import 'screens/home.dart';

void main() {
  runApp(MyAppState());
}

class MyAppState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyApp();
}

class MyApp extends State<MyAppState> {
  Amplify amplify = Amplify();
  AmplifyAuthCognito auth = AmplifyAuthCognito();
  AmplifyStorageS3 storage = AmplifyStorageS3();
  AmplifyAnalyticsPinpoint analytics = AmplifyAnalyticsPinpoint();

  bool configured = false;
  bool authenticated = false;

  @override
  initState() {
    super.initState();
    print("initState");
    // Add the Amplify category plugins, plugins should
    // be added here in order for configuration to work
    // DO NOT add plugins that you haven't configured via
    // the Amplify CLI. This will throw a configuration error.
    amplify.addPlugin(
        authPlugins: [auth],
        storagePlugins: [storage],
        analyticsPlugins: [analytics]);

    // Configure Amplify categories via the amplifyconfiguration.dart
    // configuration that was generated via the Amplify CLI
    // to generate an `amplifyconfiguration.dart` file run
    //
    // $ npm install -g @aws-amplify/cli@flutter-preview
    // $ amplify init
    //
    // from the terminal and choose "flutter" as the framework
    amplify.configure(amplifyconfig).then((value) {
      print("Amplify Configured");
      setState(() {
        configured = true;
      });
      _checkSession();
    }).catchError((e) {
      _checkSession();
    });
  }

  void _checkSession() async {
    print("Checking Auth Session...");
    var session = await auth.fetchAuthSession();
    print("AUTH_SESSION: ${session.isSignedIn}");
    setState(() {
      authenticated = session.isSignedIn;
    });
    auth.events.listenToAuth((hubEvent) {
      switch (hubEvent["eventName"]) {
        case "SIGNED_IN":
          {
            print("HUB: USER IS SIGNED IN");
            setState(() {
              authenticated = true;
            });
          }
          break;
        case "SIGNED_OUT":
          {
            print("HUB: USER IS SIGNED OUT");
            setState(() {
              authenticated = false;
            });
          }
          break;
        case "SESSION_EXPIRED":
          {
            print("HUB: USER SESSION EXPIRED");
            setState(() {
              authenticated = false;
            });
          }
          break;
        default:
          {
            print("HUB: CONFIGURATION EVENT");
          }
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Photos',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: authenticated ? Home(auth) : Authenticator());
  }
}
