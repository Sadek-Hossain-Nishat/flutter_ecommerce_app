import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/flutterecommerceapp/const/AppColors.dart';
import 'package:flutter_ecommerce_app/flutterecommerceapp/ui/bottom_nav_pages/flutter_provider.dart';
import './bottom_nav_pages/home.dart';
import './bottom_nav_pages/favourite.dart';
import './bottom_nav_pages/cart.dart';
import './bottom_nav_pages/profile.dart';
class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {

  final _pages = [Home(),Favourite(),Cart(),Profile(),FlutterProvider()];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("E-Commerce",
        style: TextStyle(color: Colors.black),),
        centerTitle: true,
        automaticallyImplyLeading: false,

      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,

        currentIndex: _currentIndex,


        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        items:[
          BottomNavigationBarItem(icon:Icon(Icons.home),label:'Home'),
          BottomNavigationBarItem(icon:Icon(Icons.favorite_outline),label:'Favourite'),
          BottomNavigationBarItem(icon:Icon(Icons.add_shopping_cart),label:'Cart'),
          BottomNavigationBarItem(icon:Icon(Icons.person),label:'Person'),
          BottomNavigationBarItem(icon:Icon(Icons.support),label:'Provider'),
        ],
        onTap: (index){
          setState(() {

            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
