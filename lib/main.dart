import 'package:connectify/screens/SplashScreen.dart';
import 'package:connectify/services/DarkNotifier.dart';
import 'package:connectify/services/Dropbox.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:connectify/services/FirebaseAuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'models/ConnectifyUser.dart';
import 'package:path_provider/path_provider.dart' as p;


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await p.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Firebase.initializeApp();
  await DropBox().initDropbox();
  await Hive.openBox('myBox');
  runApp(
    ChangeNotifierProvider<DarkNotifier>(
        create: (context) => DarkNotifier(),
        child: MyApp()
    ), // Wrap your app
  );
}


class MyApp extends StatelessWidget {

  //Global Variables

  static User user;
  static ConnectifyUser current;

  static var box = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Consumer<DarkNotifier>(
      builder: (context, appState, child){
        return MultiProvider(
          providers: [
            Provider<FirebaseAuthService>(
              create: (_) => FirebaseAuthService(),
            ),
            Provider<FirestoreService>(
              create: (_) => FirestoreService(),
            ),
          ],
          child: MaterialApp(
            title: 'Connectify',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            debugShowCheckedModeBanner: false,
            // Add the locale here
            home: SplashPage(),
            themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          ),
        );
      }
    );
  }



}

class AppTheme{

  static final ThemeData light = ThemeData(

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
  );

  static final ThemeData dark = ThemeData(

    backgroundColor: Color.fromRGBO(22, 22, 22,1 ),
    // backgroundColor: Color.fromRGBO(233, 225, 255, 1),

    //Button Colors
    buttonColor: Colors.black,
    hoverColor: Color.fromRGBO(47, 150, 255, 1),

    //Nav Bar Icon Color
    bottomAppBarColor: Colors.white,


    //General Text
    textTheme: TextTheme(
      //Main Titles
      headline1: TextStyle(
        fontFamily: 'Muli-Bold',
        color: Colors.white,
        fontSize: 20,
      ),

      //Subtitle
      subtitle1: TextStyle(
        fontFamily: 'Muli',
        color: Colors.white,
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
  );


}

