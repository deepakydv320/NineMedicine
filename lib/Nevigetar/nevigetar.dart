import 'package:flutter/material.dart';

import '../Profile/P_homepage.dart';
import '../Profile/my_orders.dart';
import 'ReferAndEarnPage.dart';
import 'home page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // List of widgets for each page
  final List<Widget> _pages = [
    Homepage(),
    ReferAndEarnPage(),
    MyOrdersPage(),
    ProfileHomePage(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex, // Control which page is shown
        children: _pages, // Pages to display
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee_rounded),
            label: "Refer & Earn",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: "My Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Accounts",
          ),
        ],
      ),
    );
  }
}

