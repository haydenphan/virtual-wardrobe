import 'package:flutter/material.dart';

class ClothItem extends StatefulWidget {
  final String name;
  final String category;
  final Map<Color, String> colorImageMap;
  final String imageUrl;

  ClothItem({
    required this.name,
    required this.category,
    required this.colorImageMap,
    required this.imageUrl,
  });

  @override
  _ClothItemState createState() => _ClothItemState();
}

class _ClothItemState extends State<ClothItem> {
  late Color selectedColor;
  late String selectedImageUrl;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.colorImageMap.keys.first;
    selectedImageUrl = widget.colorImageMap[selectedColor]!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: 250.0,
        width: 120.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  selectedImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text(widget.category, style: TextStyle(color: Colors.white, fontSize: 16)),
                    Row(
                      children: widget.colorImageMap.keys.map((color) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = color;
                            selectedImageUrl = widget.colorImageMap[color]!;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          margin: EdgeInsets.symmetric(horizontal: 2.0),
                          width: selectedColor == color ? 25 : 20,
                          height: selectedColor == color ? 25 : 20,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
