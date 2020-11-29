class ConnectifyUser{
  String username, email, password;

  ConnectifyUser({this.username, this.email, this.password});

  factory ConnectifyUser.fromMap(Map data){
    data = data ?? {};
    return ConnectifyUser(
      username: data['username'],
      email: data['email'],
      password: data['password'],
    );
  }

}