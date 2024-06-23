import 'package:flutter/material.dart';
import 'home_categories_tab.dart';
import '/services/navigation.dart';
import 'package:provider/provider.dart';

enum HomeTab {
  categories,
  friends,
  user,
}

class HomePage extends StatelessWidget {
  final HomeTab selectedTab;

  const HomePage({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<NavigationService>(context, listen: false);
    final List<Map<String, dynamic>> tabs = [
      {
        'page': const HomeCategoriesTab(),
        'title': 'Categories',
      },
      {
        // 'page': const HomeFriendsTab(),
        'title': 'Friends',
      },
      {
        // 'page': const HomeUserTab(),
        'title': 'User',
      },
    ];

    return Scaffold(
      // appbar: title (?)
      // drawer: pages (?)
      body: tabs[selectedTab.index]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          // setState(() {
          //   selectedTab = HomeTab.values[index];
          // });
          //if (index == 2) { // Assuming 'User' is the third tab (index 2)
          //  nav.goNewPage(); // Navigate to the new page
          //}
        }, 
        currentIndex: selectedTab.index,
        backgroundColor: Colors.lime.shade100,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'User',
          ),
        ],
      ),
    );
  }
}