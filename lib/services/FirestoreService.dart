import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/main.dart';
import 'package:connectify/models/ConnectifyUser.dart';

class DatabaseService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get a stream of a single document
  // Stream<ConnectifyUser> streamUsers(String id) {
  //   return _db
  //       .collection('users')
  //       .doc(id)
  //       .snapshots()
  //       .map((snapshot) => ConnectifyUser.fromMap(snapshot.data()));
  // }


  Future<ConnectifyUser> getUser(String id){
    return _db
        .collection('users')
        .doc(id)
        .get().then((value) => ConnectifyUser.fromJSON(value.data()));
  }


  /// Query a subcollection
  // Stream<List<Weapon>> streamWeapons(User user) {
  //   var ref = _db.collection('heroes').document(user.uid).collection('weapons');
  //
  //   return ref.snapshots().map((list) =>
  //       list.documents.map((doc) => Weapon.fromFirestore(doc)).toList());
  // }


  Future<List<String>> getSchools(String state) async{
    List<String> list = [];
    await _db.collection("states").doc(state).get().then((snapshot) {
      snapshot.data().forEach((key, value) {
        list.add(key);
      });
    });
    print(list);
    return list;
  }

  Future<List<String>> getStates() async{
    List<String> list = [];
    await _db.collection("states").get().then((snapshot) {
      for(int i = 0; i < snapshot.docs.length;i++){
        list.add(snapshot.docs[i].id);
      }
    });
    return list;
  }

  Future<bool> addToSchool(String state, String school, String uid)async{
    await _db.collection("users").doc(uid).update({
      "school": school,
    });
    var students = await _db.collection("states").doc(state).get().then((snapshot)=> snapshot.data()[school]);
    students.add(uid);
    return await _db.collection("states").doc(state).update({
      school: students,
    }).then((value) => true, onError: (value)=> false);
  }


  /// Write data
  Future<bool> createUser(String id, ConnectifyUser user) async{
     return await _db
         .collection('users')
         .doc(id)
         .set(user.toJSON(user)).then((value) => true, onError:(value)=> false);
  }






}