import 'package:flutter/material.dart';

class FunctionalBar extends StatefulWidget {
  @override
  _FunctionalBarState createState() => _FunctionalBarState();
}

class _FunctionalBarState extends State<FunctionalBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined, size: 30.0),
            onPressed: () {
              print('Home button pressed');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 30.0),
            onPressed: () {
              print('Shopping cart button pressed');
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(45, 149, 150, 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/camera');
                  }),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, size: 30.0),
            onPressed: () {
              print('Notification button pressed');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, size: 30.0),
            onPressed: () {
              print('Account button pressed');
            },
          ),
        ],
      ),
    );
  }
}
