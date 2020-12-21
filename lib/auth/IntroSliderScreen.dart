import 'package:connectify/nav/Navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            bodyWidget: Text("Develop Your Skills", style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15))),
            image: Center(child: Image.asset("res/images/logo.png", height: MediaQuery.of(context).size.height/1.5)),
            decoration:  PageDecoration(
              pageColor: Theme.of(context).buttonColor,
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: Text("Develop Your Skills", style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15))),
            image: Center(child: Image.asset("res/images/logo.png", height: MediaQuery.of(context).size.height/1.5)),
            decoration:  PageDecoration(
              pageColor: Theme.of(context).buttonColor,
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: Text("Develop Your Skills", style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15))),
            image: Center(child: Image.asset("res/images/logo.png", height: MediaQuery.of(context).size.height/1.5)),
            decoration:  PageDecoration(
              pageColor: Theme.of(context).buttonColor,
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: Text("Develop Your Skills", style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 15))),
            image: Center(child: Image.asset("res/images/logo.png", height: MediaQuery.of(context).size.height/1.5)),
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