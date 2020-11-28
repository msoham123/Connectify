import 'package:connectify/auth/LandingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connectify',
      theme: ThemeData(


        backgroundColor: Color.fromRGBO(242, 247, 253, 1),
        // backgroundColor: Color.fromRGBO(233, 225, 255, 1),

        //Button Colors 
        buttonColor: Color.fromRGBO(242, 114, 138, 1),
        hoverColor: Color.fromRGBO(47, 150, 255, 1),


        //General Text
        textTheme: TextTheme(
          //Main Titles
            headline1: TextStyle(
              fontFamily: 'Muli-Bold',
              color: Colors.black,
              fontSize: 20,
            ),

            //Subtitle
            subtitle1: TextStyle(
              fontFamily: 'Muli',
              color: Colors.black,
              fontSize: 15,
            ),


           //Button 1 Text
           button: TextStyle(
             fontFamily: 'Muli',
             color: Colors.white,
             fontSize: 15,
           ),


          //Textfield

          subtitle2: TextStyle(
            color:  Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),



        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }



}

