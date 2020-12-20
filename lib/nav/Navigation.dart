import 'package:connectify/widgets/NavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Navigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NavigationState();
  }


}

class NavigationState extends State<Navigation>{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: NavigationBar(),
      body: Container(
        child: Center(
          child: FlatButton(
            child: Text("Reset"),
            onPressed: ()=> Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: Navigation()), (Route<dynamic> route) => false),
          ),
        ),
      ),
    );
  }

}