import 'package:connectify/auth/LandingScreen.dart';
import 'package:connectify/services/DatabaseService.dart';
import 'package:connectify/services/FirebaseAuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(), // Wrap your app
  );
}


class MyApp extends StatelessWidget {

  //Global Variables

  static User user;



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
      ],
      child: MaterialApp(
        title: 'Connectify',
        theme: ThemeData(


          backgroundColor: Color.fromRGBO(242, 247, 253, 1),
          // backgroundColor: Color.fromRGBO(233, 225, 255, 1),

          //Button Colors
          buttonColor: Color.fromRGBO(242, 114, 138, 1),
          hoverColor: Color.fromRGBO(47, 150, 255, 1),

          //Nav Bar Icon Color
          bottomAppBarColor: Colors.black,


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
               fontFamily: 'Muli-Bold',
               color: Colors.white,
               fontSize: 15,
             ),

            //Button 2 Text
            headline4: TextStyle(
              fontFamily: 'Muli-Bold',
              color: Colors.blue,
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
         // Add the locale here
        home: LandingScreen(),
      ),
    );
  }



}

