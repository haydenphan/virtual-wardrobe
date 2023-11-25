import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/model/searchbar.dart' as CustomSearchBar;
import 'package:virtual_wardrobe/model/clothitem.dart' as ClothItems;
import 'package:virtual_wardrobe/model/functionalbar.dart' as FunctionalBar;
import 'package:virtual_wardrobe/utils/constant.dart';

import '../api/post_image.api.dart';
import '../model/product.model.dart';
import 'detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Product>> getSuggestionItems() async {
    return getItems();
  }

  void navigateToDetail(Product product) {
    getItem(product.id).then((value) {
      product = value;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  product: product,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: FutureBuilder(
          future: getSuggestionItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: AppColors.primary,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Welcome, Khanh Nhi'),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        icon: const Icon(Icons.account_circle, size: 32.0),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CustomSearchBar.SearchBar(
                          hintText: 'Search',
                        ),
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          children: snapshot.data!
                              .map((product) => GestureDetector(
                            onTap: () => navigateToDetail(product),
                                child: ClothItems.ClothItem(
                                      product: product,
                                    ),
                              ))
                              .toList(),
                        ),
                      ),
                      FunctionalBar.FunctionalBar(),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
