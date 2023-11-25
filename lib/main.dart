import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/pages/home.dart';
import 'package:virtual_wardrobe/pages/camera.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      '/camera': (context) =>  CameraScreen(cameras: cameras)
    },
  ));
}
