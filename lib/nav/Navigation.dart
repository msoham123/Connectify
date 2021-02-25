import 'package:animations/animations.dart';
import 'package:connectify/nav/ChatScreen.dart';
import 'package:connectify/nav/HomeScreen.dart';
import 'package:connectify/nav/ProfileScreen.dart';
import 'package:connectify/nav/SearchScreen.dart';
import 'package:connectify/nav/StartupScreen.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Navigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NavigationState();
  }


}

class NavigationState extends State<Navigation>{

  //This is a navigator helper that provides utilities such as the bottom navigation bar and indexing

  int index = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        selectedColor: Theme.of(context).buttonColor,
        strokeColor: Theme.of(context).buttonColor,
        unSelectedColor: Colors.grey[600],
        backgroundColor: Theme.of(context).backgroundColor,
        items: [
          CustomNavigationBarItem(
            icon: Center(
              child: Icon(
                AntDesign.home,
                size: 25,
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Center(
              child: Icon(
                AntDesign.CodeSandbox,
                size: 25,
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Center(
              child: Icon(
                AntDesign.message1,
                size: 25,
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Center(
              child: Icon(
                AntDesign.search1,
                size: 25,
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Center(
              child: Icon(
                AntDesign.user,
                size: 25,
              ),
            ),
          ),
        ],
        currentIndex: index,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
      ),
      body: PageTransitionSwitcher(
        duration: Duration(milliseconds: 250),
        transitionBuilder: (widget, anim1, anim2) {
          return FadeScaleTransition(
            animation: anim1,
            child: widget,
          );
        },
        child: IndexedStack(
          index: index,
          children: [
            HomePage(),
            StartupPage(),
            ChatPage(),
            SearchPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }



  // Container(
  // child: Center(
  // child: FlatButton(
  // child: Text("Reset"),
  // onPressed: ()=> Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: IntroSliderScreen())),
  //
  // // onPressed: ()=> Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: Navigation()), (Route<dynamic> route) => false),
  // ),
  // ),
  // ),

}