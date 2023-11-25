import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:virtual_wardrobe/api/post_image.api.dart';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:virtual_wardrobe/pages/widgets/suggestion_items.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final IO.Socket socket = IO.io('http://172.16.255.213:5000/stream');

  CameraScreen({super.key, required this.cameras});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final StreamController<bool> _isProcessingController = StreamController();

  @override
  void initState() {
    super.initState();
    final frontCamera = widget.cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
    );
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void takePictureEverySecond() async {
    while (true && _controller.value.isInitialized) {
      await Future.delayed(const Duration(seconds: 1));
      final rs = await _controller.takePicture();
      //Push to api to process
      //TODO: add id
      print("i take pucture behind the screen");
      File image = File(rs.path);
      postImage(image, 'id go here');
      //transfer image to server
      widget.socket.emit('image', image.readAsBytesSync());
    }
  }

  @override
  Widget build(BuildContext context) {
    _isProcessingController.stream.listen((event) {
      if (event) {
        takePictureEverySecond();
      }
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_controller),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Trial Room'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: const SuggestionItems())),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(89, 157, 159, 1),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt_rounded,
                      size: 35.0, color: Color.fromARGB(255, 255, 255, 255)),
                  onPressed: () async {
                    try {
                      await _initializeControllerFuture;

                      final image = await _controller.takePicture();
                      _isProcessingController.add(true);
                      //Change camera to back
                      _controller = CameraController(
                        widget.cameras.firstWhere(
                          (camera) =>
                              camera.lensDirection == CameraLensDirection.back,
                        ),
                        ResolutionPreset.low,
                        enableAudio: false,
                        imageFormatGroup: ImageFormatGroup.yuv420,
                      );
                      postImage(File(image.path), 'id go here')
                          .then((value) => {
                                showImagePreviewPopup(context, value).then(
                                    (value) =>
                                        _isProcessingController.add(false))
                              });
                    } catch (e, stacktrace) {
                      debugPrintStack(
                          label: e.toString(), stackTrace: stacktrace);
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

Future<dynamic> showImagePreviewPopup(BuildContext context, String image) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Image.network(image),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
