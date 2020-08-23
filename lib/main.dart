import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';

import 'screens/auth.dart';

void main() {
  runApp(MyAppState());
}

class MyAppState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyApp();
}

class MyApp extends State<MyAppState> {
  Amplify amplify = Amplify();
  bool configured = false;

  @override
  initState() {
    super.initState();
    configureAmplify();
  }

  void configureAmplify() async {
    AmplifyAuthCognito auth = AmplifyAuthCognito();
    AmplifyStorageS3 storage = AmplifyStorageS3();
    AmplifyAnalyticsPinpoint analytics = AmplifyAnalyticsPinpoint();

    amplify.addPlugin(
        authPlugins: [auth],
        storagePlugins: [storage],
        analyticsPlugins: [analytics]);

    await amplify.configure(amplifyconfig);

    setState(() {
      configured = true;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amplify',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Authenticator(),
    );
  }
}
