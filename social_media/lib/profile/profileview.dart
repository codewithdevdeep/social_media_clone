
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/login.dart';
import 'package:social_media/profile/wiget/profileheder.dart';
import 'package:social_media/profile/wiget/profilepost_card.dart';
import 'package:social_media/profile/wiget/profilereels.dart';
import 'package:social_media/profile/wiget/profilesave.dart';


// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
            backgroundColor: Color(0xFF1B1B1B),
            title: Text("Profile", selectionColor: Colors.white),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Badge(
                      textColor: Colors.white,
                      label: Text("5"),
                      child: Icon(Icons.notifications))),
              PopupMenuButton(
                  child: Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Logout"),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) => LoginView())));
                        },
                      ))
                    ];
                  })
            ],
          ),
          body: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
               
                ];
              },
              body: Column(



                children: [
                  SizedBox(height: 20,),



                   Column(
                  children: [
                    CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                "https://img.freepik.com/free-vector/hand-drawn-korean-drawing-style-character-illustration_23-2149623257.jpg?size=338&ext=jpg&ga=GA1.2.647470437.1685963067&semt=robertav1_2_sidr"),
                          ),
                          SizedBox(height: 15,),
                            Text("VIVEK SHARMA",style: TextStyle(color: Colors.white),),
                            Text("Flutter devloper | Graphics deginer",style: TextStyle(color: Colors.white),),
                                Text("Code whisperer by day, coffee snob by night",style: TextStyle(color: Colors.white),)
                
                  ],
                ),

                  SizedBox(height: 20,),
            Row(
              children: [
               
                SizedBox(width: 100,),

                Column(
                  children: [
                    Text("25",style: TextStyle(color: Colors.white,fontSize: 24),),
                     Text("post",style: TextStyle(color: const Color.fromARGB(255, 94, 92, 92),fontSize: 15),)
                  ],
                ),
                SizedBox(width: 40,),
                Column(
                  children: [
                    Text("250k",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("Followers",style: TextStyle(color: const Color.fromARGB(255, 92, 90, 90),fontSize: 15))
                  ],
                ),
                 SizedBox(width: 40,),
                Column(
                  children: [
                    Text("250",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("Folowing",style: TextStyle(color: const Color.fromARGB(255, 102, 101, 101),fontSize: 15)),
                  ],
                ),

              ],
            ),
            SizedBox(height:40,),





                  TabBar(tabs: [
                    Tab(
                      icon: Icon(Icons.add_a_photo),
                    ),
                    Tab(
                      icon: Icon(Icons.play_circle_outline),
                    ),
                    Tab(
                      icon: Icon(Icons.bookmark_outline),
                    ),
                  ]),
                  Expanded(
                    child: TabBarView(children: [
                      ProfilePostCards(),
                      ProfileReelsCards(),
                      ProfileSaveCards(),
                    ]),
                  )
                ],
              ))),
    );
  }
}





