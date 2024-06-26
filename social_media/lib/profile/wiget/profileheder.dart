
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/profile/wiget/editprofile.dart';


class ProfileHeaderCard extends StatelessWidget {
  ProfileHeaderCard({
    super.key,
    required this.userId,
  });

  final String userId;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    print("Fetching user with ID: $userId"); // Debug print

    return SliverToBoxAdapter(
      child: FutureBuilder<DocumentSnapshot>(
        future: users.doc(userId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("Error fetching user data: ${snapshot.error}"); // Debug print
            return Text("Something went wrong. Please try again later.");
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            print("Document does not exist for user ID: $userId"); // Debug print
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "User profile not found. Please check if the user is registered.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          print("User data fetched: $data"); // Debug print
          return ProfileCard(userData: data);
        },
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.userData,
  });
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color(0xFF1B1B1B),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Color(0xCAF15800),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(userData["profileUrl"]),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 5,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: Icon(Icons.add_circle_outline)),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                ProfileCountTitle(
                  title: 'Post',
                  count: '25',
                ),
                CustomDivider(),
                ProfileCountTitle(
                  title: 'Followers',
                  count: '250K',
                ),
                CustomDivider(),
                ProfileCountTitle(
                  title: 'Following',
                  count: '250',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userData["userName"],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => EditProfile(
                                userDetails: userData,
                              ))));
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            Text(userData["bio"]),
            SizedBox(
              height: 5,
            ),
            Text(
              userData["des"],
              style: TextStyle(color: Colors.grey.shade400),
            ),
            SizedBox(
              height: 30,
              child: TextButton(onPressed: () {}, child: Text(userData["url"])),
            )
          ],
        ));
  }
}

class ProfileCountTitle extends StatelessWidget {
  const ProfileCountTitle({
    super.key,
    required this.count,
    required this.title,
  });

  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        )
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
        color: Colors.grey.shade600,
        width: 2.0,
      ))),
    );
  }
}
