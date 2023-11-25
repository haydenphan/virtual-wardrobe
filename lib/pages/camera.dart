import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:virtual_wardrobe/model/selecteditem.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen({required this.cameras});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    final frontCamera = widget.cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_controller),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Camera Screen'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                  SelectedItem(selectedImageUrl: 'assets/blazer.png'),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(89, 157, 159, 1),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt_rounded, 
                    size: 35.0, 
                    color: Color.fromARGB(255, 255, 255, 255)
                  ),
                  onPressed: () async {
                    try {
                      await _initializeControllerFuture;
              
                      final image = await _controller.takePicture();
              
                      // If the picture was taken, display it on a new screen.
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(imagePath: image.path),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  DisplayPictureScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.file(File(imagePath));
  }
}
