import 'package:connectify/auth/LandingScreen.dart';
import 'package:connectify/main.dart';
import 'package:connectify/screens/SplashScreen.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:connectify/services/FirebaseAuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }

}

class LoginScreenState extends State<LoginScreen>{

  //This is the login screen of the application. The user can fill out fields to sign in or sign in with google

  TextEditingController email = TextEditingController(), password = TextEditingController() ;
  bool _inAsyncCall = false;
  GoogleSignInAccount google;



  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    google = googleUser;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    // Once signed in, get the UserCredential
    return await Provider.of<FirebaseAuthService>(context, listen: false).signInWithGoogle(credential);
  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inAsyncCall,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height/25,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, size: 30,),
                  onPressed: ()=> Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: LandingScreen()), (route)=> route is LandingScreen),
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
                        enableFeedback: false,
                        onPressed: ()=>null,
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
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: IconButton(
                        enableFeedback: false,
                        onPressed: ()=>null,
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
                  onPressed: () async{
                    if(email.text.contains(".com")&&email.text.length>4&&password.text.isNotEmpty) {
                      setState(() {
                        _inAsyncCall = true;
                      });
                      try{
                        MyApp.user = await Provider.of<FirebaseAuthService>(context, listen: false).signInWithEmailAndPassword(email.text.trim(), password.text.trim());
                      }catch(e){
                        Dialogs.materialDialog(
                            msg: 'Could not sign in. Please try again.',
                            title: "Error",
                            color: Colors.white,
                            context: context,
                            actions: [
                              FlatButton(
                                child: Text("Close", style: Theme.of(context).textTheme.button,),
                                color: Theme.of(context).buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                onPressed: ()=> Navigator.pop(context),
                              ),
                            ]
                        );
                      }
                    }
                    if(MyApp.user!=null) {
                      MyApp.current = await Provider.of<FirestoreService>(context, listen: false).getUser(MyApp.user.uid);
                      MyApp.box.put("email", email.text.trim());
                      MyApp.box.put("password", password.text.trim());
                      Navigator.pushAndRemoveUntil(context, PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: SplashPage()), (Route<
                          dynamic> route) => false);
                    }
                      setState(() {
                      _inAsyncCall = false;
                      });
                    },
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 14,
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign In with Google",
                        style: Theme.of(context).textTheme.button,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        AntDesign.google,
                        color: Theme.of(context).textTheme.button.color,
                      )
                    ],
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: () async {
                    // if(email.text.contains(".com")&&email.text.length>4&&password.text.isNotEmpty) {
                    setState(() {
                      _inAsyncCall = true;
                    });
                    try {
                      MyApp.user = await signInWithGoogle();
                    } catch (e) {
                      print(e);
                      Dialogs.materialDialog(
                          msg: 'Could not sign in. Please try again.',
                          title: "Error",
                          color: Colors.white,
                          context: context,
                          actions: [
                            FlatButton(
                              child: Text(
                                "Close",
                                style: Theme.of(context).textTheme.button,
                              ),
                              color: Theme.of(context).buttonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ]);
                    }
                    if (MyApp.user != null) {
                      MyApp.current = await Provider.of<FirestoreService>(context, listen: false).getUser(MyApp.user.uid);
                      MyApp.isGoogle = true;
                      Navigator.pushAndRemoveUntil(context, PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          child: SplashPage()), (Route<
                          dynamic> route) => false);
                        // MyApp.box.put("email", email.text.trim());
                        // MyApp.box.put("password", password.text.trim());
                    }
                    setState(() {
                      _inAsyncCall = false;
                    });
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}