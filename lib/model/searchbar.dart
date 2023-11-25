import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller = TextEditingController();

  SearchBar({this.hintText = 'Default Hint Text'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: Color.fromRGBO(45, 148, 150, 0.553)),
            onPressed: () {
              print(controller.text);
            },
          ),
        ),
      ),
    );
  }
}
