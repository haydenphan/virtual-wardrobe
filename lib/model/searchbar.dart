import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/utils/constant.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller = TextEditingController();

  SearchBar({this.hintText = 'Default Hint Text', super.key});

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
            icon: const Icon(Icons.search, color: AppColors.secondary),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
