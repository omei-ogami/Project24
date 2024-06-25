import 'package:flutter/material.dart';
import 'package:project_24/data/testing_data.dart';
import 'package:project_24/main.dart';
import 'home_categories_tab.dart';
import 'home_friends_tab.dart';
import 'package:project_24/home_settings_tab.dart';
import 'home_chatroom_tab.dart';
import '/services/navigation.dart';
import 'package:provider/provider.dart';

enum HomeTab {
  categories,
  friends,
  activities,
  settings
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
        'page':  HomeFriendsTab(friends: dummyFriends),
        'title': 'Friends',
      },
      {
        'page': const HomeChatroomTab(),
        'title': 'Activities',
      },
      {
        'page': const HomeSettingsTab(),
        'title': 'Settings',
      },
    ];

    return Scaffold(
      //appBar: AppBar(
      //  title: Text(tabs[selectedTab.index]['title']),
      //),
      // drawer: const HomeDrawer(),
      body: tabs[selectedTab.index]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          nav.goHome(tab: HomeTab.values[index]);
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
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}