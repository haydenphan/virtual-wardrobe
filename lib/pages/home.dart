import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/model/searchbar.dart' as CustomSearchBar;
import 'package:virtual_wardrobe/model/clothitem.dart' as ClothItems;
import 'package:virtual_wardrobe/model/functionalbar.dart' as FunctionalBar;
import 'package:virtual_wardrobe/utils/constant.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                children: [
                  ClothItems.ClothItem(
                    name: 'Blazer',
                    category: 'Outdoor',
                    colorImageMap: {
                      Color.fromARGB(255, 186, 149, 136): 'assets/blazer.png',
                      Colors.black: 'assets/blackblazer.jpg',
                      Colors.white: 'assets/whiteblazer.jpg',
                    },
                    imageUrl: 'assets/blazer.png',
                  ),
                  ClothItems.ClothItem(
                    name: 'Blazer',
                    category: 'Outdoor',
                    colorImageMap: {
                      Color.fromARGB(255, 186, 149, 136): 'assets/blazer.png',
                      Colors.black: 'assets/blackblazer.jpg',
                      Colors.white: 'assets/whiteblazer.jpg',
                    },
                    imageUrl: 'assets/blazer.png',
                  ),
                  ClothItems.ClothItem(
                    name: 'Blazer',
                    category: 'Outdoor',
                    colorImageMap: {
                      Color.fromARGB(255, 186, 149, 136): 'assets/blazer.png',
                      Colors.black: 'assets/blackblazer.jpg',
                      Colors.white: 'assets/whiteblazer.jpg',
                    },
                    imageUrl: 'assets/blazer.png',
                  ),
                  ClothItems.ClothItem(
                    name: 'Blazer',
                    category: 'Outdoor',
                    colorImageMap: {
                      Color.fromARGB(255, 186, 149, 136): 'assets/blazer.png',
                      Colors.black: 'assets/blackblazer.jpg',
                      Colors.white: 'assets/whiteblazer.jpg',
                    },
                    imageUrl: 'assets/blazer.png',
                  ),
                  ClothItems.ClothItem(
                    name: 'Blazer',
                    category: 'Outdoor',
                    colorImageMap: {
                      Color.fromARGB(255, 186, 149, 136): 'assets/blazer.png',
                      Colors.black: 'assets/blackblazer.jpg',
                      Colors.white: 'assets/whiteblazer.jpg',
                    },
                    imageUrl: 'assets/blazer.png',
                  ),
                  ClothItems.ClothItem(
                    name: 'Blazer',
                    category: 'Outdoor',
                    colorImageMap: {
                      Color.fromARGB(255, 186, 149, 136): 'assets/blazer.png',
                      Colors.black: 'assets/blackblazer.jpg',
                      Colors.white: 'assets/whiteblazer.jpg',
                    },
                    imageUrl: 'assets/blazer.png',
                  ),
                  ClothItems.ClothItem(
                    name: 'Blazer',
                    category: 'Outdoor',
                    colorImageMap: {
                      Color.fromARGB(255, 186, 149, 136): 'assets/blazer.png',
                      Colors.black: 'assets/blackblazer.jpg',
                      Colors.white: 'assets/whiteblazer.jpg',
                    },
                    imageUrl: 'assets/blazer.png',
                  ),
                  ClothItems.ClothItem(
                    name: 'Blazer',
                    category: 'Outdoor',
                    colorImageMap: {
                      Color.fromARGB(255, 186, 149, 136): 'assets/blazer.png',
                      Colors.black: 'assets/blackblazer.jpg',
                      Colors.white: 'assets/whiteblazer.jpg',
                    },
                    imageUrl: 'assets/blazer.png',
                  ),
                ],
              ),
            ),
            FunctionalBar.FunctionalBar(),
          ],
        ),
      ),
    );
  }
}
