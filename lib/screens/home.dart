import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'capture.dart';

class Home extends StatefulWidget {
  Home({Key key, @required this.auth}) : super(key: key);
  @override
  HomeState createState() => HomeState();

  final AmplifyAuthCognito auth;
}

class HomeState extends State<Home> {
  dynamic _openCameraView(BuildContext context) async {
    try {
      var cameras = await availableCameras();
      if (cameras.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Capture(camera: cameras.first)));
      } else {
        print("No cameras found");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openCameraView(context),
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Capture a photo',
          child: Icon(Icons.add_a_photo),
        ),
        appBar: AppBar(
          title: Text("Photos"),
          actions: [
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  widget.auth.signOut(request: null);
                })
          ],
          leading: Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: Image.asset('assets/amplify.png')),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [],
              ),
            )
          ],
        ));
  }
}
