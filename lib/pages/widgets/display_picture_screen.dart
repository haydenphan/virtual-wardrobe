import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatefulWidget {
  final File image;

  const DisplayPictureScreen({super.key, required this.image});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  @override
  Widget build(BuildContext context) {
    return Image.file(widget.image);
  }
}
