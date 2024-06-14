
import 'package:flutter/material.dart';
import 'package:social_media/home/wiget/like.dart';
import 'package:social_media/home/wiget/post_image.dart';



class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.likeImagesList,
    required this.postData,
  });

  final List<String> likeImagesList;
  final dynamic postData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(postData: postData),
          SizedBox(
            height: 15,
          ),
          PostImages(),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: Image.network(
          //     postData['imageUrl'],
          //     height: 280,
          //     width: double.infinity,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  LikesImages(
                    likeImages: likeImagesList,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("15 Likes",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white)),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.favorite_border_outlined),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.message_outlined),
                ],
              ),
              Icon(Icons.bookmark_border_outlined),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "View All 48 comments",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.postData,
  });

  final dynamic postData;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(postData['profileImage']),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postData['userName'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white),
            ),
            Text('15 mins ago', style: TextStyle(color: Colors.white38))
          ],
        )
      ]),
      Icon(Icons.more_vert)
    ]);
  }
}
