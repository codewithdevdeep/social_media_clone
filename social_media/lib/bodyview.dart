import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/home/homepage.dart';
import 'package:social_media/navbar.dart';
import 'package:social_media/post.dart';
import 'package:social_media/profile/profileview.dart';
import 'package:social_media/search.dart';



class BodyView extends StatefulWidget {
  const BodyView({super.key});

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  int currentIndex = 0;
  var pageViewList = [
    HomeView(),
  SearchView(),
  PostView(),
    Container(
      color: Colors.amber,
      alignment: Alignment.center,
      child: Text('Page 4'),
    ),
 ProfileView(userId: FirebaseAuth.instance.currentUser!.uid,)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        onDestinationSelected: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedIndex: currentIndex,
      ),
      body: pageViewList[currentIndex],
    );
  }
}
