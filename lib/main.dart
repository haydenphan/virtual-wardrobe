import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/pages/home.dart';
import 'package:virtual_wardrobe/pages/camera.dart';
import 'package:camera/camera.dart';


List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(username: 'Khanh Nhi'),
      '/camera':(context) => CameraScreen(cameras: cameras),
    },
  ));
}
