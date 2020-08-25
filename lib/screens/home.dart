import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class Home extends StatelessWidget {
  AmplifyAuthCognito _auth;
  CameraDescription firstCamera;
  List<CameraDescription> cameras;

  Home(AmplifyAuthCognito auth) {
    this._auth = auth;
    this._initCamera();
  }

  /**
   * Initialize the device camera
   * Ensure that plugin services are initialized
   * and Obtain a list of the available cameras on the device.
   */
  void _initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      this.cameras = await availableCameras();
      this.firstCamera = cameras.first;
    } catch (e) {
      print("error getting available cameras");
      print(e);
    }
  }

  dynamic _openCameraView(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(camera: this.firstCamera)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => this._openCameraView(context),
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
                  this._auth.signOut(request: null);
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

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_enhance),
        backgroundColor: Colors.white,
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt),
        backgroundColor: Theme.of(context).accentColor,
        // Provide an onPressed callback.
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      appBar: AppBar(title: Text('Edit and Save')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
