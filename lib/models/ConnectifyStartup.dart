class ConnectifyStartup{
  String title, description, uid, path, link;
  Map<String, String> comments;

  ConnectifyStartup({this.title, this.description,this.uid, this.path, this.comments, this.link});

  factory ConnectifyStartup.fromJSON(Map<String, dynamic> data){
    data = data ?? {};
    return ConnectifyStartup(
      description: data['description'],
      uid: data['uid'],
      path: data['path'],
      comments: data['comments'].cast<String,String>(),
      link: data['link'],
      title: data['title']
    );
  }


  Map<String, dynamic> toJSON(ConnectifyStartup instance) => <String, dynamic>{
    'description': instance.description,
    'uid': instance.uid,
    'path': instance.path,
    'comments': instance.comments,
    'link': instance.link,
    'title': instance.title
  };
}