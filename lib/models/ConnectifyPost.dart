import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ConnectifyPost{
  String description, uid, path, hashtags;
  Map<String, String> comments;
  List<String> stars;
  ScrollController _controller = ScrollController();
  DateTime datePublished;

  ConnectifyPost({this.description,this.uid, this.path, this.comments, this.stars, this.datePublished, this.hashtags});

  factory ConnectifyPost.fromJSON(Map<String, dynamic> data){
    data = data ?? {};
    return ConnectifyPost(
      description: data['description'],
      uid: data['uid'],
      path: data['path'],
      comments: data['comments'].cast<String,String>(),
      stars: data['stars'].cast<String>(),
      datePublished: (data['datePublished'] as Timestamp).toDate(),
      hashtags: data['hashtags']
    );
  }


  Map<String, dynamic> toJSON(ConnectifyPost instance) => <String, dynamic>{
    'description': instance.description,
    'uid': instance.uid,
    'path': instance.path,
    'comments': instance.comments,
    'stars': instance.stars,
    'datePublished': instance.datePublished,
    'hashtags': instance.hashtags
  };
}