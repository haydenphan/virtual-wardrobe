import 'package:flutter/material.dart';
import 'package:virtual_wardrobe/model/searchbar.dart' as CustomSearchBar;
import 'package:virtual_wardrobe/model/clothitem.dart' as ClothItems;
import 'package:virtual_wardrobe/model/functionalbar.dart' as FunctionalBar;

class Home extends StatefulWidget {
  final String username;

  Home({required this.username});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(45, 148, 150, 0.553),
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Welcome, ${widget.username}'),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.account_circle,
                  size: 40.0), 
              onPressed: () {
                print('Account button pressed');
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(45, 148, 150, 0.553),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 360.0,
                    height: 85.0,
                    child: CustomSearchBar.SearchBar(
                      hintText: 'Search',
                    )),
              ],
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

// gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color.fromRGBO(45, 149, 150, 1),
//                       Colors.white
//                     ]
//                   )