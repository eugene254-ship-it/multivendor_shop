import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:multivendor_shop/constants/colors.dart';
import 'cart.dart';
import 'favorites.dart';
import 'home.dart';
import 'profile.dart';
import 'category.dart';
import 'shop.dart';

class SellerBottomNav extends StatefulWidget {
  static const routeName = '/seller-home';

  const SellerBottomNav({Key? key}) : super(key: key);

  @override
  State<SellerBottomNav> createState() => _SellerBottomNavState();
}

class _SellerBottomNavState extends State<SellerBottomNav> {
  var currentPageIndex = 0;
  final _pages = const [
    HomeScreen(),
    FavoriteScreen(),
    CategoryScreen(),
    ShopScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  selectPage(var index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: litePrimary,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.grey,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: primaryColor,
        activeColor: Colors.white,
        initialActiveIndex: currentPageIndex,
        style: TabStyle.reactCircle,
        items: const [
          TabItem(
            icon: Icons.house_siding,
          ),
          TabItem(
            icon: Icons.favorite_border,
          ),
          TabItem(
            icon: Icons.category_outlined,
          ),
          TabItem(
            icon: Icons.storefront,
          ),
          TabItem(
            icon: Icons.shopping_cart_outlined,
          ),
          TabItem(
            icon: Icons.person_outline,
          )
        ],
        onTap: selectPage,
      ),
      backgroundColor: Colors.grey.shade200,
      body: _pages[currentPageIndex],
    );
  }
}