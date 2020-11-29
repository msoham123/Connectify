import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/models/ConnectifyUser.dart';

class DatabaseService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get a stream of a single document
  Stream<ConnectifyUser> streamUsers(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snapshot) => ConnectifyUser.fromMap(snapshot.data()));
  }

  /// Query a subcollection
  // Stream<List<Weapon>> streamWeapons(User user) {
  //   var ref = _db.collection('heroes').document(user.uid).collection('weapons');
  //
  //   return ref.snapshots().map((list) =>
  //       list.documents.map((doc) => Weapon.fromFirestore(doc)).toList());
  // }


  /// Write data
  Future<void> createUser(String id) {
    return _db.collection('users').doc(id).set({ /* some data */ });
  }






}