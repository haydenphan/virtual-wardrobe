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
  final IO.Socket socket = IO.io(baseUrl);

  CameraScreen({super.key, required this.cameras});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  // late Timer _timer;
  // final StreamController<bool> _isProcessingController = StreamController();
  // late st

  int currentIndex = 0;
  List<Product> products = [];
  bool isLoading = false;

  Future<List<Product>> getSuggestionItems() async {
    return getItems();
  }

  @override
  void initState() {
    super.initState();
    final frontCamera = widget.cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
    );
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _initializeControllerFuture = _controller.initialize();
    // Start timer
    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   if (_controller.value.isInitialized) {
    //     takePictureEverySecond();
    //   }
    // });
    // _isProcessingController.stream.listen((event) {
    //   if (event) {
    //     takePictureEverySecond();
    //   }
    // });
    // Get products
    getSuggestionItems().then((value) {
      setState(() {
        products = value;
      });
    });
  }

  void takePictureEverySecond() async {
    // try {
    //   final image = await _controller.takePicture();
    //   print(image.path);
    //   // widget.socket.emit('stream', image.readAsBytes());
    // } catch (e) {
    //   print('Taking picture Error: $e');
    // }
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final image = await _controller.takePicture();
      print(image.path);
      widget.socket.emit('stream',
          {'image': image.path, 'product_id': products[currentIndex].id});
      setState(() {});
    } catch (e) {
      print('Taking picture Error: $e');
    }
  }

  Future<File> captureStaticImage() async {
    try {
      final image = await _controller.takePicture();
      final tryonImage =
          takeStaticPicture(File(image.path), products[currentIndex].id);
      return tryonImage;
    } catch (e) {
      print('Taking picture Error: $e');
      throw e;
    }
  }

  @override
  void dispose() {
    // _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void flipCamera() async {
    final frontCamera = widget.cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    final backCamera = widget.cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
    );
    if (_controller.description == frontCamera) {
      _controller = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
    } else {
      _controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
    }
    await _controller.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // takePictureEverySecond();
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
              decoration: BoxDecoration(
                color: isLoading
                    ? Color.fromRGBO(72, 98, 99, 1)
                    : Color.fromRGBO(89, 157, 159, 1),
                shape: BoxShape.circle,
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt_rounded,
                            size: 35.0,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        onPressed: isLoading
                            ? null
                            : () async {
                                try {
                                  await _initializeControllerFuture;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final image = await captureStaticImage();
                                  setState(() {
                                    isLoading = false;
                                  });
                                  // // If the picture was taken, display it on a new screen.
                                  // await Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         DisplayPictureScreen(image: image),
                                  //   ),
                                  // );
                                  // flipCamera();
                                  await showImagePreviewPopup(context, image,
                                      () {
                                    // flipCamera();
                                  });
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

Future<dynamic> showImagePreviewPopup(
    BuildContext context, File image, VoidCallback? onConfirm) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: Image.file(image),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm?.call();
          },
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
