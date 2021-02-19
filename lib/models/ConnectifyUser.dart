import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/services/Dropbox.dart';

class ConnectifyUser{
  String username, email, password, school, description;
  List<String> following, followers, posts, messages;
  DateTime dateAccountCreated;
  List<String> saved, groups, notifications;
  String image;
  List<String> startups;

  ConnectifyUser({this.username, this.email, this.password, this.school, this.description, this.following, this.followers, this.posts, this.messages, this.dateAccountCreated, this.saved, this.groups, this.startups, this.notifications, this.image});

  factory ConnectifyUser.fromJSON(Map<String, dynamic> data) {

    data = data ?? {};
    return ConnectifyUser(
      username: data['username'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
      school: data['school'] as String,
      description: data['description'] as String,
      following: data['following'].cast<String>(),
      followers: data['followers'].cast<String>(),
      posts: data['posts'].cast<String>(),
      messages: data['messages'].cast<String>(),
      dateAccountCreated: (data['dateAccountCreated'] as Timestamp).toDate(),
      groups: data['groups'].cast<String>(),
      saved: data['saved'].cast<String>(),
      notifications: data['notifications'].cast<String>(),
      image:  data['image'],
      startups: data['startups'].cast<String>(),
    );
  }




  Map<String, dynamic> toJSON(ConnectifyUser instance) => <String, dynamic>{
    'username': instance.username,
    'email': instance.email,
    'password': instance.password,
    'school': instance.school,
    'description': instance.description,
    'following': instance.following,
    'followers': instance.followers,
    'posts': instance.posts,
    'messages': instance.messages,
    'dateAccountCreated': instance.dateAccountCreated,
    'groups': instance.groups,
    'notifications': instance.notifications,
    'image': instance.image,
    'saved': instance.saved,
    'startups': instance.startups,
  };
}