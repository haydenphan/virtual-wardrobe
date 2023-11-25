import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/utils/constant.dart';

class SelectedItem extends StatelessWidget {
  String selectedImageUrl;
  bool? isSelected;

  SelectedItem({required this.selectedImageUrl, this.isSelected = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected! ? AppColors.primary : Colors.transparent,
          width: 4.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        image: DecorationImage(
            image: NetworkImage(selectedImageUrl), fit: BoxFit.cover),
      ),
    );
  }
}
