import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;

const String USER_COLLECTION = "users";
const String POST_COLLECTION = "posts";

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Map? currentUser;

  FirebaseService();

  Future<bool> loginUser({
    required String email,
    required String password
  }) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        currentUser = await getUserData(uid: userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async{
    DocumentSnapshot doc = await _db.collection(USER_COLLECTION).doc(uid).get();
    return doc.data() as Map;
  }

  Future<bool> registerUser({
    required String email,
    required String password,
    required String name,
    required File image,
  }) async {
    try{
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String userId = userCred.user!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString()
          + p.extension(image.path);

      UploadTask task = _storage.ref('images/$userId/$fileName').putFile(image);
      return task.then((snapshot) async {
        String downloadURL = await snapshot.ref.getDownloadURL();
        await _db.collection(USER_COLLECTION).doc(userId).set({
          'name': name,
          'email': email,
          'image': downloadURL
        });
        return true;
      });
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> postImage(File image) async{
    try{
      String userId = _auth.currentUser!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);

      UploadTask task = _storage.ref('images/$userId/$fileName').putFile(image);
      return task.then((snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await _db.collection(POST_COLLECTION).add({
          'userId': userId,
          'timestamp': Timestamp.now(),
          'image': downloadUrl,
        });
        return true;
      });
    }catch(e){
      return false;
    }
  }

  Stream<QuerySnapshot> getLatestPosts(){
    return _db.collection(POST_COLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
