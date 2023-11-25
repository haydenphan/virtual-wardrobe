import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/api/post_image.api.dart';

import '../../model/product.model.dart';

class SuggestionItems extends StatelessWidget {
  const SuggestionItems({super.key});

  Future<List<Product>> getSuggestionItems() async {
    return getItems();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSuggestionItems(),
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.done) &&
              snapshot.hasData &&
              snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final Product product = snapshot.data![index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.description),
                  leading: Image.network(
                    product.previewUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
