import 'package:connectify/services/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }

}

class LoginScreenState extends State<LoginScreen>{
  final auth = FirebaseAuth.instance;
  final db = DatabaseService();

  TextEditingController email = TextEditingController(), password = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    bool loggedIn = user != null;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height/25,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, size: 30,),
                  onPressed: ()=> Navigator.pop(context),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/100,
              ),

              Center(
                child: Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/50,
              ),


              Text(
                "Log In to Continue",
                style: Theme.of(context).textTheme.subtitle1,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/20,
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10),
                child: SvgPicture.asset(
                  "assets/images/login.svg",
                  height: MediaQuery.of(context).size.height/6 ,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/20,
              ),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[400],
                  ),
                  width: MediaQuery.of(context).size.width>800 ? MediaQuery.of(context).size.width/4 :  MediaQuery.of(context).size.width/1.2,
                  child: TextField(
                    controller: email,
                    style: TextStyle(
                        color: Color(0xFFF234253),
                        fontWeight: FontWeight.bold),
                    obscureText: false,
                    decoration: InputDecoration(
                      icon: IconButton(
                        icon: Icon(Icons.email),
                        color: Colors.blueGrey,
                        hoverColor: Colors.white30,
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      hoverColor: Color(0xFF094074),
                      hintText: "Email",
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[400],
                  ),
                  width: MediaQuery.of(context).size.width>800 ? MediaQuery.of(context).size.width/4 :  MediaQuery.of(context).size.width/1.2,
                  child: TextField(
                    controller: password,
                    style: TextStyle(
                        color: Color(0xFFF234253),
                        fontWeight: FontWeight.bold),
                    obscureText: false,
                    decoration: InputDecoration(
                      icon: IconButton(
                        icon: Icon(Icons.lock),
                        color: Colors.blueGrey,
                        hoverColor: Colors.white30,
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      hoverColor: Color(0xFF094074),
                      hintText: "Password",
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/20,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width/1.2,
                height: MediaQuery.of(context).size.height/14,
                child: FlatButton(
                  child: Text("Log In", style: Theme.of(context).textTheme.button,),
                  color: Theme.of(context).buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  onPressed: ()=> null,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width/1.2,
                height: MediaQuery.of(context).size.height/14,
                child: FlatButton(
                  child: Text("Create new account", style: Theme.of(context).textTheme.button,),
                  color: Theme.of(context).hoverColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  onPressed: ()=> null,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/10,
              ),

            ],
          ),
        ),
      ),
    );
  }

}