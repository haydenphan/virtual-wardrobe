import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/model/product.model.dart';

class ClothItem extends StatefulWidget {
  final Product product;

  const ClothItem({
    super.key,
    required this.product,
  });

  @override
  State<ClothItem> createState() => _ClothItemState();
}

class _ClothItemState extends State<ClothItem> {
  late String selectedColor;
  late String selectedImageUrl;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.product.colors.first;
    selectedImageUrl = widget.product.previewUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                selectedImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.title,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20)),
                  Text(widget.product.categories.join(","),
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
