import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/main.dart';
import 'package:connectify/models/ConnectifyPost.dart';
import 'package:connectify/models/ConnectifyStartup.dart';
import 'package:connectify/models/ConnectifyUser.dart';
import 'package:connectify/widgets/Post.dart';
import 'package:connectify/widgets/Startup.dart';
import 'package:flutter/cupertino.dart';

import 'Dropbox.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DropBox box = DropBox();

  /// Get a stream of a single document
  // Stream<ConnectifyUser> streamUsers(String id) {
  //   return _db
  //       .collection('users')
  //       .doc(id)
  //       .snapshots()
  //       .map((snapshot) => ConnectifyUser.fromMap(snapshot.data()));
  // }

  Future<bool> sendFeedback(String feedback) async{
    try{
      await _db.collection("feedback").add({
        "feedback" : feedback,
        "email" : MyApp.current.email,
        "uid" : MyApp.user.uid,
      });
      return true;
    }catch(e){
      return false;
    }
  }

  Future<List<Widget>> getPostSearch(String search, double height) async{
    List<Widget> output = [];
    List<ConnectifyPost> list = [];
    List<String> postID = [];
    await box.loginWithAccessToken();
    await box.listFolder("");
    await _db.collection("posts").get().then((snapshot) => {
      for(int i = snapshot.docs.length-1; i>=0; i--){
          if(snapshot.docs[i].data()['description'].toLowerCase().contains(search.toLowerCase()) || snapshot.docs[i].data()['hashtags'].toLowerCase().contains(search.toLowerCase())){
            list.add(ConnectifyPost.fromJSON(snapshot.docs[i].data())),
            postID.add(snapshot.docs[i].id),
          }
      }});
    for(int i = 0; i<list.length;i++){
      output.add(
          Post(
            description: list[i].description,
            uid: list[i].uid,
            imageUrl: await box.getTemporaryLink(list[i].path),
            stars: list[i].stars,
            comments: list[i].comments,
            datePublished: list[i].datePublished,
            hashtags: list[i].hashtags,
            postId: postID[i],
            isImage: list[i].isImage,
          ),
      );
      output.add(SizedBox(height: height));
    }
    return output;
  }

  Future<List<Widget>> getStartupSearch(String search, double height) async{
    List<Widget> output = [];
    List<ConnectifyStartup> list = [];
    List<String> startupID = [];
    await box.loginWithAccessToken();
    await box.listFolder("");
    await _db.collection("startups").get().then((snapshot) => {
      for(int i = snapshot.docs.length-1; i>=0; i--){
        if(snapshot.docs[i].data()['description'].toLowerCase().contains(search.toLowerCase()) || snapshot.docs[i].data()['title'].toLowerCase().contains(search.toLowerCase())){
          list.add(ConnectifyStartup.fromJSON(snapshot.docs[i].data())),
          startupID.add(snapshot.docs[i].id),
        }
      }});
    for(int i = 0; i<list.length;i++){
      output.add(
        Startup(
          description: list[i].description,
          uid: list[i].uid,
          imageUrl: await box.getTemporaryLink(list[i].path),
          comments: list[i].comments,
          startupId: startupID[i],
          title: list[i].title,
          link: list[i].link,
        ),
      );
      output.add(SizedBox(height: height));
    }
    return output;
  }
  
  Future<void> addPostToProfile(String uid, String postId, List<String> posts) async{
    posts.add(postId);
    await _db.collection("users").doc(uid).update(
      {
        "posts": posts,
      }
    );
  }

  Future<void> updateProfileImage(String path, String uid) async{
    await _db.collection("users").doc(uid).update(
        {
          "image" : path
        }
    );
  }

  Future<void> updateProfileInfo(String username, String description, String uid) async{
    await _db.collection("users").doc(uid).update(
        {
          "username" : username,
          "description" : description,
        }
    );
  }

  Future<void> addStartupToProfile(String uid, String startupId, List<String> startups) async{
    startups.add(startupId);
    await _db.collection("users").doc(uid).update(
        {
          "startups": startups,
        }
    );
  }

  Future<List<List<dynamic>>> getPosts()async{
    List<ConnectifyPost> list = [];
    List<String> postID = [];
    await _db.collection("posts").orderBy("datePublished", descending: false).get().then((snapshot){
      for(int i = snapshot.docs.length-1; i>=0; i-- ){
        list.add(ConnectifyPost.fromJSON(snapshot.docs[i].data()));
        postID.add(snapshot.docs[i].id);
      }
    });
    return [list,postID];
  }

  Future<List<List<dynamic>>> getStartups()async{
    List<ConnectifyStartup> list = [];
    List<String> startupId = [];
    await _db.collection("startups").get().then((snapshot){
      for(int i = snapshot.docs.length-1; i>=0; i-- ){
        list.add(ConnectifyStartup.fromJSON(snapshot.docs[i].data()));
        startupId.add(snapshot.docs[i].id);
      }
    });
    return [list, startupId];
  }


  Future<List<Widget>> getProfilePosts(List<String> posts, double height) async{
    List<ConnectifyPost> list = [];
    List<String> postID = [];
    List<Widget> output = [];
    for(int j = posts.length-1; j>=0; j-- ){
      var snapshot = await  _db.collection("posts").doc(posts[j]).get();
      list.add(ConnectifyPost.fromJSON(snapshot.data()));
      postID.add(posts[j]);
    }
    for(int i = 0; i<list.length;i++){
      output.add(
        Post(
          description: list[i].description,
          uid: list[i].uid,
          imageUrl: await box.getTemporaryLink(list[i].path),
          stars: list[i].stars,
          comments: list[i].comments,
          datePublished: list[i].datePublished,
          hashtags: list[i].hashtags,
          postId: postID[i],
          isImage: list[i].isImage,
        ),
      );
      output.add(SizedBox(height: height));
    }
    return output;
  }

  Future<List<Widget>> getProfileStartups(List<String> startups, double height) async{
    List<ConnectifyStartup> list = [];
    List<String> startupId = [];
    List<Widget> output = [];
    for(int j = startups.length-1; j>=0; j-- ){
      var snapshot = await  _db.collection("startups").doc(startups[j]).get();
      list.add(ConnectifyStartup.fromJSON(snapshot.data()));
      startupId.add(startups[j]);
    }
    for(int i = 0; i<list.length;i++){
      output.add(
        Startup(
          description: list[i].description,
          uid: list[i].uid,
          imageUrl: await box.getTemporaryLink(list[i].path),
          comments: list[i].comments,
          title: list[i].title,
          link: list[i].link,
          startupId: startupId[i],
        ),
      );
      output.add(SizedBox(height: height));
    }
    return output;
  }

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

  Future<bool> createPost(String postId, ConnectifyPost post) async{
    return await _db
        .collection('posts')
        .doc(postId)
        .set(post.toJSON(post)).then((value) => true, onError:(value)=> false);
  }

  Future<bool> createStartup(String startupId, ConnectifyStartup startup) async{
    return await _db
        .collection('startups')
        .doc(startupId)
        .set(startup.toJSON(startup)).then((value) => true, onError:(value)=> false);
  }

  Future<void> incrementStar(String postId, List<String> current)async {
    return await _db
        .collection('posts')
        .doc(postId)
        .update({
      'stars': current,
    });
  }

}