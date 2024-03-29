import 'package:connectify/main.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'IntroSliderScreen.dart';

class SchoolScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SchoolScreenState();
  }

}

class SchoolScreenState extends State<SchoolScreen>{

  //This is the screen where users can choose what school they go to and which state they are from. These states and schools come from our database.
  //If you only see California and Fremont High School (or others) while using the app, we have not populated this database. For release, we will have this database populated
  //We plan to populate the database with all American High Schools and Colleges

  bool  _inAsyncCall = false;
  ScrollController _controller = ScrollController();
  bool _school = false, _state = false;
  TextEditingController school = TextEditingController(), state = TextEditingController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    school.dispose();
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inAsyncCall,
      child: Scaffold(
        body: CupertinoScrollbar(
          controller: _controller,
          child: ListView(
            controller: _controller,
            children: _index == 0 ? [

              SizedBox(
                height: MediaQuery.of(context).size.height/10,
              ),

              Center(
                child: Text(
                  "Select your State",
                  style: Theme.of(context).textTheme.headline1,
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
                  child: TypeAheadField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: state,
                      onChanged: (value){
                        state.text = value;
                        setState(() {
                          _state = false;
                        });
                      },
                      style: TextStyle(
                          color: Color(0xFFF234253),
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        icon: IconButton(
                          enableFeedback: false,
                          onPressed: ()=>null,
                          icon: Icon(Icons.search),
                          color: Colors.blueGrey,
                          hoverColor: Colors.white30,
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hoverColor: Color(0xFF094074),
                        hintText: 'Search For State',
                        hintStyle: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return await Provider.of<FirestoreService>(context, listen: false).getStates();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        leading: Icon(Icons.school),
                        title:  Text(
                          suggestion,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      state.text = suggestion;
                      setState(() {
                        _state = true;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/20,
              ),

              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  height: MediaQuery.of(context).size.height/14,
                  child: FlatButton(
                    child: Text("Next", style: Theme.of(context).textTheme.button,),
                    color: Theme.of(context).buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    disabledColor: Colors.grey,
                    onPressed: !_state ? null: () {
                      setState(() {
                        _index = 1;
                      });
                    },
                  ),
                ),
              ),


            ] : [

              SizedBox(
                height: MediaQuery.of(context).size.height/10,
              ),


              Center(
                child: Text(
                  "Select your School",
                  style: Theme.of(context).textTheme.headline1,
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
                  child: TypeAheadField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: school,
                      onChanged: (value){
                        school.text = value;
                        setState(() {
                          _school = false;
                        });
                      },
                      style: TextStyle(
                          color: Color(0xFFF234253),
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        icon: IconButton(
                          enableFeedback: false,
                          onPressed: ()=>null,
                          icon: Icon(Icons.search),
                          color: Colors.blueGrey,
                          hoverColor: Colors.white30,
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hoverColor: Color(0xFF094074),
                        hintText: 'Search For School',
                        hintStyle: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return await Provider.of<FirestoreService>(context, listen: false).getSchools(state.text);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        leading: Icon(Icons.school),
                        title:  Text(
                          suggestion,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      );
                    },

                    onSuggestionSelected: (suggestion) {
                      school.text = suggestion;
                      setState(() {
                        _school = true;
                      });
                    },
                  ),
                ),
              ),


              SizedBox(
                height: MediaQuery.of(context).size.height/20,
              ),

              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  height: MediaQuery.of(context).size.height/14,
                  child: FlatButton(
                    disabledColor: Colors.grey,
                    child: Text("Confirm", style: Theme.of(context).textTheme.button,),
                    color: Theme.of(context).buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    onPressed: !_school ? null : () async{
                      setState(() {
                        _inAsyncCall = true;
                      });
                      bool response = await Provider.of<FirestoreService>(context, listen: false).addToSchool(state.text, school.text, MyApp.user.uid);
                      if(response){
                        setState(() {
                          _inAsyncCall = false;
                        });
                        Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: IntroSliderScreen()), (Route<dynamic> route) => false);
                      }else{
                        Dialogs.materialDialog(
                            msg: 'Could not add to school. Please try again.',
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
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}