
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

class NavBar extends StatelessWidget {
  const NavBar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_literals_to_create_immutables
    return NavigationBar(
      backgroundColor: Colors.black,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        // ignore: prefer_const_literals_to_create_immutables
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.home_outlined,color: Colors.white,),
              selectedIcon: Icon(Icons.home,color: Colors.white,),
              label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.person_search_outlined,color: Colors.white,),
              selectedIcon: Icon(Icons.person_search,color: Colors.white,),
              label: "Search"),
          NavigationDestination(
              icon: Icon(Icons.add_circle_outline,color: Colors.white,),
              selectedIcon: Icon(Icons.add_circle,color: Colors.white,),
              label: "Post"),
          NavigationDestination(
              icon: Icon(Icons.play_circle_outline,color: Colors.white,),
              selectedIcon: Icon(Icons.play_circle),
              label: "Reels"),
          NavigationDestination(
              icon: Icon(Icons.account_circle_outlined,color: Colors.white,),
              selectedIcon: Icon(Icons.account_circle,color: Colors.white,),
              label: "Profile"),
        ]);
  }
}
