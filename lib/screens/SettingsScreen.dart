import 'package:connectify/services/DarkNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlive_switch/xlive_switch.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ScrollController _controller = ScrollController();
  TextEditingController feedback = TextEditingController();
  bool darkMode = false, analytics = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).buttonColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.button.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).buttonColor,
          ),
          CupertinoScrollbar(
            controller: _controller,
            child: ListView(
              controller: _controller,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 8,
                              width: MediaQuery.of(context).size.height / 8,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(MyApp.current.image)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context).buttonColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width /2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                MyApp.current.username,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .merge(TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 50,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height / 14,
                                child: FlatButton(
                                  child: Text(
                                    "Sign Out",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  color: Theme.of(context).buttonColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Analytics",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .merge(TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                    ),
                    XlivSwitch(
                      value: analytics,
                      onChanged: (val) {
                        setState(() {
                          analytics = val;
                        });
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Dark Mode",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .merge(TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                    ),
                    XlivSwitch(
                      value: Provider.of<DarkNotifier>(context).isDarkMode,
                      onChanged: (val) {
                        Provider.of<DarkNotifier>(context, listen: false).updateTheme(val);
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),

                Center(
                  child: Text(
                    "Feedback Form",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .merge(TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 60,
                ),

                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[400],
                    ),
                    width: MediaQuery.of(context).size.width>800 ? MediaQuery.of(context).size.width/4 :  MediaQuery.of(context).size.width/1.2,
                    child: TextField(
                      controller: feedback,
                      maxLines: 5,
                      style: TextStyle(
                          color: Color(0xFFF234253),
                          fontWeight: FontWeight.bold),
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hoverColor: Color(0xFF094074),
                        hintStyle: Theme.of(context).textTheme.subtitle2,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width/1.6,
                    height: MediaQuery.of(context).size.height/18,
                    child: FlatButton(
                      disabledColor: Colors.grey,
                      child: Text("Send", style: Theme.of(context).textTheme.button,),
                      color: Theme.of(context).buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      onPressed: (){

                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

}
