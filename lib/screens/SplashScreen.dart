import 'package:connectify/auth/LandingScreen.dart';
import 'package:connectify/nav/Navigation.dart';
import 'package:connectify/services/DarkNotifier.dart';
import 'package:connectify/services/Dropbox.dart';
import 'package:connectify/services/FirebaseAuthService.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage>{


  @override
  void initState(){
    super.initState();
    if(!MyApp.isGoogle)Future.delayed(Duration.zero, () {
      loadSettings();
      loadProfile();
    });
    else
      Future.delayed(Duration.zero, () {
        Navigator.pushAndRemoveUntil(context, PageTransition(
            type: PageTransitionType.fade,
            child: Navigation()), (Route<
            dynamic> route) => false);
      });

  }

  @override
  void dispose(){
    super.dispose();
  }

  void loadSettings()async{
    if(MyApp.box.get('darkMode')=="true"){
      Provider.of<DarkNotifier>(context, listen: false).updateTheme(true);
    }
  }

  void loadProfile()async{
    DropBox box = DropBox();
    await box.loginWithAccessToken();
    await box.listFolder("");
    if(MyApp.box.get('email')!=null && MyApp.box.get("password")==null) {
      try{
        MyApp.user =
        await Provider.of<FirebaseAuthService>(context, listen: false)
            .signInWithEmailAndPassword(
            MyApp.box.get('email'), MyApp.box.get("password"));
        if(MyApp.user!=null) {
          MyApp.current = await Provider.of<FirestoreService>(context, listen: false).getUser(MyApp.user.uid);
          MyApp.current.image = await box.getTemporaryLink(MyApp.current.image);
          Future.delayed(Duration.zero, () {
            Navigator.pushAndRemoveUntil(context, PageTransition(
                type: PageTransitionType.fade,
                child: Navigation()), (Route<
                dynamic> route) => false);
          });
        }else{
          Future.delayed(Duration.zero, () {
            Navigator.pushAndRemoveUntil(context, PageTransition(
                type: PageTransitionType.fade,
                child: LandingScreen()), (Route<
                dynamic> route) => false);
          });
        }
      }catch(e){
        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(context, PageTransition(
              type: PageTransitionType.fade,
              child: LandingScreen()), (Route<
              dynamic> route) => false);
        });
      }
    }else{
      Future.delayed(Duration.zero, () {
        Navigator.pushAndRemoveUntil(context, PageTransition(
            type: PageTransitionType.fade,
            child: LandingScreen()), (Route<
            dynamic> route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).buttonColor,
        child: Center(
          child: Image.asset(
              'assets/images/logo.png',
            height: MediaQuery.of(context).size.height/3,
          ),
        ),
      ),
    );
  }


}