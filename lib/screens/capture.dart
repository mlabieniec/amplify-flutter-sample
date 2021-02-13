import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_flutter/amplify.dart';

// A screen that allows users to take a picture using a given camera.
class Capture extends StatefulWidget {
  final CameraDescription camera;

  const Capture({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  CaptureState createState() => CaptureState();
}

class CaptureState extends State<Capture> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  _toast(context, message) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

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
            // Attempt to take a picture and log where it's been saved.
            var file = await _controller.takePicture();
            print("Capture saved:");
            print(file.path);
            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen(imagePath: file.path),
              ),
            );
          } on Exception catch (e) {
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
        child: Icon(Icons.cloud_upload),
        backgroundColor: Theme.of(context).primaryColor,
        // Provide an onPressed callback.
        onPressed: () {
          print("Uploading file...");
          print(imagePath);
          var key = new DateTime.now().toString();
          Map<String, String> metadata = <String, String>{};
          metadata['name'] = 'flutter-amplify-$key';
          metadata['desc'] = 'Uploaded with Amplify for Flutter';
          S3UploadFileOptions options = S3UploadFileOptions(
              accessLevel: StorageAccessLevel.protected, metadata: metadata);
          try {
            File local = File(imagePath);
            Amplify.Storage.uploadFile(key: key, local: local, options: options)
                .then((UploadFileResult result) {
              Navigator.pop(context);
            }).catchError((error) {
              Navigator.pop(context);
              print(error);
            });
          } on Exception catch (e) {
            Navigator.pop(context);
            print(e);
          }
        },
      ),
      appBar: AppBar(title: Text('Upload Photo')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
