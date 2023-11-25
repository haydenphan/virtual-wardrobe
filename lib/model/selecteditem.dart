import 'package:flutter/material.dart';

class SelectedItem extends StatelessWidget {

  String selectedImageUrl;

  SelectedItem({required this.selectedImageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(selectedImageUrl,
          height: 200.0, width: 200.0,),
    );
  }
}