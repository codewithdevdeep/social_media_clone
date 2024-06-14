import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/firestoreservice.dart';
import 'package:social_media/imagepicker.dart';
import 'package:social_media/postbottomsheet.dart';
import 'package:uuid/uuid.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final mediaPicker = MediaPicker();
  final List<Map<String, dynamic>> _mediaFiles = [];
  final _desController = TextEditingController();
  final List<String> imageUrlList = [];
  bool isLoader = false;
  final firestoreService = FirestoreService();
  final uuid = Uuid();

  void pickImages() async {
    Navigator.pop(context);
    var pickedFiles = await mediaPicker.pickImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _mediaFiles.addAll(pickedFiles);
      });
    }
  }

  Future<void> takePicture() async {
    Navigator.pop(context);
    var pickedFile = await mediaPicker.takePicture();
    if (pickedFile.isNotEmpty) {
      setState(() {
        _mediaFiles.add(pickedFile);
      });
    }
  }

  Future<void> pickVideo() async {
    Navigator.pop(context);
    var pickedFile = await mediaPicker.videoPick();
    if (pickedFile.isNotEmpty) {
      setState(() {
        _mediaFiles.add(pickedFile);
      });
    }
  }

  Future<void> uploadFile() async {
    for (var file in _mediaFiles) {
      var imageUrl = await firestoreService.uploadFile(File(file['thumbnailFile']));
      setState(() {
        imageUrlList.add(imageUrl);
      });
    }
  }

  Future<void> uploadPost() async {
    if (_desController.text.isEmpty && _mediaFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill details")),
      );
      return;
    }

    setState(() {
      isLoader = true;
    });

    try {
      await uploadFile();
      var id = uuid.v4();
      var createAt = DateTime.now().microsecondsSinceEpoch;

      var postData = {
        "id": id,
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "createAt": createAt,
        "likesImages": [],
        "commentsCount": 0,
        "likesCount": 0,
        "description": _desController.text,
        "postImages": imageUrlList
      };

      await firestoreService.addPost(postData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Post Uploaded")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" post Uploaded ")),
      );
    } finally {
      setState(() {
        isLoader = false;
        _desController.clear();
        _mediaFiles.clear();
      });
    }
  }

  void removeMedia(int index) {
    setState(() {
      _mediaFiles.removeAt(index);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: SizedBox(
        height: 40,
        width: 80,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 66, 53),
          ),
          onPressed: isLoader ? null : uploadPost,
          child: isLoader
              ? Center(child: CircularProgressIndicator())
              : Text("Post"),
        ),
      ),
      appBar: AppBar(title: Text("Upload Post")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Write Something", style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                TextField(
                  maxLines: null,
                  controller: _desController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Color.fromARGB(255, 53, 53, 53),
                  ),
                ),
                SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _mediaFiles.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            MediaBottomSheet.show(
                              context,
                              pickImages,
                              takePicture,
                              pickVideo,
                            );
                          },
                          icon: Icon(Icons.add_a_photo, color: Colors.white),
                        ),
                      );
                    }
                    var mediaFile = _mediaFiles[index - 1];
                    var thumbnailFile = File(mediaFile['thumbnailFile']);
                    var isVideo = mediaFile['mediaType'] == 'video';
                    return InkWell(
                      onLongPress: () {
                        RemoveMediaBottomSheet.show(context, () {
                          removeMedia(index - 1);
                        });
                      },
                      child: Stack(
                        children: [
                          Image.file(
                            thumbnailFile,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          if (isVideo)
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_circle_filled,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
