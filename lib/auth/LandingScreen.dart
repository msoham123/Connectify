import 'package:connectify/auth/LoginScreen.dart';
import 'package:connectify/auth/SignUpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LandingScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LandingScreenState();
  }

}

class LandingScreenState extends State<LandingScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [


            SizedBox(
              height: MediaQuery.of(context).size.height/10,
            ),

            Center(
              child: (MediaQuery.of(context).size.width<400) ? Text(
                "Connect. Grow. \nCreate Together.",
                style: Theme.of(context).textTheme.headline1,
              ) : Text(
                "Connect. Grow. Create Together.",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height/50,
            ),

            Center(
              child: Text(
                "Discover and Connect with Amazing People",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height/40,
            ),
            
            // Expanded(
            //   child: Padding(
            //     padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10),
            //     child: SvgPicture.asset(
            //         "assets/images/landing.svg",
            //     ),
            //   ),
            // ),

            Expanded(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10),
                child: Image.asset(
                  "assets/images/landing.png",
                ),
              ),
            ),



            SizedBox(
              width: MediaQuery.of(context).size.width/1.2,
              height: MediaQuery.of(context).size.height/14,
              child: FlatButton(
                child: Text("Get Started", style: Theme.of(context).textTheme.button,),
                color: Theme.of(context).buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                onPressed: ()=> Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: SignUpScreen())),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height/40,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width/1.2,
              height: MediaQuery.of(context).size.height/14,
              child: FlatButton(
                child: Text("Already have an account", style: Theme.of(context).textTheme.headline4,),
                // color: Theme.of(context).hoverColor,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(10))
                // ),
                onPressed: ()=> Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: LoginScreen())),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height/20,
            ),

          ],
        ),
      ),
    );
  }

}