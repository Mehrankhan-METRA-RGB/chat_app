import 'dart:io';
import 'dart:math';

import 'package:chat_app/Data/StaticData/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  static CollectionReference collections =
      FirebaseFirestore.instance.collection(AppCollections.users.name);

  static Future<Map<String, dynamic>> signIn(String email, String pass) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      await collections.doc(user.user!.uid).get();
      return {'success': true, 'error': null};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> signUp(Map<String, dynamic> user) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user['email'], password: user['password']);
      String uid = credential.user!.uid;
      if (user['file'] != null) {
        await uploadImage(user['file']).then((url) {
          user.addAll({'url': url});

          addUser(uid, user);
        });
      } else {
        user.addAll({'url': credential.user?.photoURL ?? ''});

        addUser(uid, user);
      }
      return {'success': true, 'error': null};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  static Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return Future.error('Failed');
    }
  }

  static Future<bool> addUser(String id, Map<String, dynamic> data) async {
    try {
      data.remove('password');
      data.remove('confirm_password');
      data['_id'] = id;
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();

      await collections.doc(id).set(data);

      return true;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  static Future<String> uploadImage(File file) async {
    return await FirebaseStorage.instance
        .ref('/Images')
        .child("Profile/${Random().nextInt(1000000)}")
        .putFile(File(file.path))
        .then((snapshot) async {
      return await snapshot.ref.getDownloadURL();
    });
  }
}
