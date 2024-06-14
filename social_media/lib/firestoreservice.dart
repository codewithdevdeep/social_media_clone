
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference post = FirebaseFirestore.instance.collection('posts');
  

  Future<void> addUser(data) async {
    try {
      await users.doc(data['id']).set(data);
    } catch (error) {
      print("Failed to add user: $error");
      throw error;
    }
  }

Future<void> addPost(Map<String, dynamic> data) async {
  try {
    await FirebaseFirestore.instance.collection('posts').doc(data['id']).set(data);
    print("Post added successfully");
  } catch (error) {
    print("post add successfully: ");
    throw error;
  }
}

  Future<String> uploadFile(File selectedFile) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('files')
        .child(selectedFile.path.split('/').last);

    try {
      var uploadTask = await ref.putFile(selectedFile);
      var downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(data, context) async {
    try {
      await users.doc(data['id']).update(data);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Accout Updated")));
    } catch (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("updation Failed"),
              content: Text(error.toString()),
            );
          });
      throw error;
    }
  }
  
 static Future<List<String>> getImageUrls() async {
    final storage = FirebaseStorage.instance;
    final result = await storage.ref('posts').listAll();
    List<String> imageUrls = [];
    for (var item in result.items) {
      String downloadUrl = await item.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }
}
