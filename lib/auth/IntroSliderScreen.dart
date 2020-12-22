import 'package:connectify/nav/Navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

class IntroSliderScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return IntroSliderScreenState();
  }
}

class IntroSliderScreenState extends State<IntroSliderScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).buttonColor,
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "",
            bodyWidget: SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  Expanded(child: SvgPicture.asset("assets/images/skills.svg")),
                  Text("Learn and Enhance Your Skills", style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15))),
                ],
              ),
            ),
            decoration:  PageDecoration(
              pageColor: Theme.of(context).buttonColor,
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  Expanded(child: SvgPicture.asset("assets/images/chat.svg")),
                  Text("Connect and Chat With Other Students", style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15))),
                ],
              ),
            ),
            decoration:  PageDecoration(
              pageColor: Theme.of(context).buttonColor,
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  Expanded(child: SvgPicture.asset("assets/images/worktogether.svg")),
                  Text("Create and Join Startups", style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15))),
                  Text("Find Opportunities", style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15))),
                ],
              ),
            ),
            decoration:  PageDecoration(
              pageColor: Theme.of(context).buttonColor,
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  Expanded(child: SvgPicture.asset("assets/images/portfolio.svg")),
                  Text("Build Your Profile and Professional Network", style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15))),
                ],
              ),
            ),
            decoration:  PageDecoration(
              pageColor: Theme.of(context).buttonColor,
            ),
          ),
        ],
        showNextButton: true,
        next: Text("Next", style: Theme.of(context).textTheme.button),
        done: Text("Done", style: Theme.of(context).textTheme.button),
        onDone: () {
          Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: Navigation()), (Route<dynamic> route) => false);
        },
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.blue,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)
            )
        ),
      ),
    );
  }

}