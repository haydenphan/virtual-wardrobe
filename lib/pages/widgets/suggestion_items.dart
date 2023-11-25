import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/api/post_image.api.dart';

import '../../model/product.model.dart';

class SuggestionItems extends StatefulWidget {
  const SuggestionItems({super.key});

  @override
  State<SuggestionItems> createState() => _SuggestionItemsState();
}

class _SuggestionItemsState extends State<SuggestionItems> {
  Future<List<Product>> getSuggestionItems() async {
    return getItems();
  }

  Product? selectedProduct;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSuggestionItems(),
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.done) &&
              snapshot.hasData &&
              snapshot.data != null) {
            return ProductListItem(snapshot: snapshot.data as List<Product>?);
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class ProductListItem extends StatefulWidget {
  const ProductListItem({super.key, this.snapshot});
  final List<Product>? snapshot;
  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {

  Product? selectedProduct;

  void initState() {
    super.initState();
    selectedProduct = widget.snapshot![0];
  }

  void setSelectedProduct(Product product) {
    setState(() {
      selectedProduct = product;
    });
  }

  @override
  Widget build(BuildContext context) {
  final List<Product> snapshot = widget.snapshot!;
    return ListView.builder(
      itemCount: snapshot != null ? snapshot!.length : 0,
      scrollDirection: Axis.horizontal,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final Product product = snapshot![index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedProduct = product;
            });
          },
          child: Container(
            width: 200,
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: selectedProduct?.id == product.id
                    ? Colors.blue
                    : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    product.previewUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(product.title),
              ],
            ),
          ),
        );
      },
    );
  }
}

