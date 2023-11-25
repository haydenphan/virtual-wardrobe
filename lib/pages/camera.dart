import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:virtual_wardrobe/api/post_image.api.dart';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:virtual_wardrobe/pages/widgets/display_picture_screen.dart';

import 'package:virtual_wardrobe/pages/widgets/suggestion_items.dart';
import 'package:virtual_wardrobe/utils/constant.dart';

import '../model/product.model.dart';
import '../model/selecteditem.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final IO.Socket socket = IO.io('$baseUrl/stream');
  final StreamController<bool> _isProcessingController = StreamController();

  CameraScreen({super.key, required this.cameras});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  int currentIndex = 0;
  List<Product> products = [];

  Future<List<Product>> getSuggestionItems() async {
    return getItems();
  }

  @override
  void initState() {
    super.initState();
    final frontCamera = widget.cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _initializeControllerFuture = _controller.initialize();
    // Get products
    getSuggestionItems().then((value) {
      setState(() {
        products = value;
      });
    });
  }

  void takePictureEverySecond() async {
    while (true && _controller.value.isInitialized) {
      await Future.delayed(const Duration(milliseconds: 200));
      final rs = await _controller.takePicture();
      // Push to api to process
      File image = File(rs.path);
      // postImage(image, '1');
      //transfer image to server
      widget.socket.emit('image', image.readAsBytesSync());
    }
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
                double mediaHeight = _controller.value.aspectRatio *
                    MediaQuery.of(context).size.width;
                double scale = MediaQuery.of(context).size.height / mediaHeight;
                return Transform.scale(
                    scale: scale,
                    child: Center(child: CameraPreview(_controller)));
                return Center(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: products.map((product) {
                  final i = products.indexOf(product);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: SelectedItem(
                        selectedImageUrl: product.previewUrl,
                        isSelected: currentIndex == i ? true : false),
                  );
                }).toList(),
              ),
            ),
          ),
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

                      // If the picture was taken, display it on a new screen.
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              DisplayPictureScreen(imagePath: image.path),
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
