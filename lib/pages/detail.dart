import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/model/product.model.dart';
import 'package:virtual_wardrobe/utils/constant.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(product.previewUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(product.title, style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(product.price.toString(), style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
          ),
          Row(
            children: product.colors.map((color) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color(int.parse(color, radix: 16)),
                  shape: BoxShape.circle,
                ),
              );
            }).toList(),
          ),
          Row(
            children: product.categories.map((category) {
              return Container(
                margin: const EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(category, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/camera', arguments: product);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(45, 149, 150, 1),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Center(
                child: Text(
                  'Try on',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
