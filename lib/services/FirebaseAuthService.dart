import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {

  final CollectionReference users = Firestore.instance.collection('users');
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(User user) {
    return user == null ? null : user;
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(result.user);
  }

  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(result.user);
  }

  Future<DocumentSnapshot> getUserDocumentSnapshot(String uid) async {
    try {
      return await users.doc(uid).get();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

}