class ConnectifyUser{
  String username, email, password, school, description;
  List<String> following, followers, posts, messages;
  DateTime dateAccountCreated;
  List<String> saved, groups, notifications;

  ConnectifyUser({this.username, this.email, this.password, this.school, this.description, this.following, this.followers, this.posts, this.messages, this.dateAccountCreated, this.saved, this.groups, this.notifications});

  factory ConnectifyUser.fromMap(Map data){
    data = data ?? {};
    return ConnectifyUser(
      username: data['username'],
      email: data['email'],
      password: data['password'],
      school: data['school'],
      description: data['description'],
      following: data['following'],
      followers: data['followers'],
      posts: data['posts'],
      messages: data['messages'],
      dateAccountCreated: data['dateAccountCreated'],
      groups: data['groups'],
      notifications: data['notifications']
    );
  }


  Map<String, dynamic> toJSON(ConnectifyUser instance) => <String, dynamic>{
    'username': username,
    'email': email,
    'password': password,
    'school': school,
    'description': description,
    'following': following,
    'followers': followers,
    'posts': posts,
    'messages': messages,
    'dateAccountCreated': dateAccountCreated,
    'groups': groups,
    'notifications': notifications
  };
}