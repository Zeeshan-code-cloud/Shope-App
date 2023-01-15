import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../Controllers/Product_utils.dart';
import 'All_categories_page.dart';
import 'Card_page.dart';
import 'Favourite_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final products = Product_Utils.product_list;
  final searchController = TextEditingController();

  int _currentIndex = 0;
  List<Widget> nav_item_list = [
    const Icon(
      Icons.home_outlined,
      color: Colors.black,
      size: 30,
    ),
    const Icon(
      Icons.favorite_outline,
      color: Colors.black,
      size: 30,
    ),
    const Icon(
      Icons.shopping_cart_outlined,
      color: Colors.black,
      size: 30,
    ),
  ];

  List<Widget> NavigationItem_list = [
    all_categories_page(),
    favourite_page(),
    card_page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 160, 167, 179),
        items: nav_item_list,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 350),
        height: 60,
        index: _currentIndex,
        onTap: (int i) {
          setState(() {
            _currentIndex = i;
          });
        },
      ),
      body: NavigationItem_list[_currentIndex],
    );
  }
}
