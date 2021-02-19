import 'package:connectify/models/ConnectifyUser.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Startup extends StatefulWidget{

  final String title, description, uid, imageUrl, startupId, link;
  final Map<String, String> comments;
  // final ScrollController _controller = ScrollController();

  Startup({this.title, this.description,this.uid, this.imageUrl, this.comments,this.startupId, this.link});

  @override
  State<StatefulWidget> createState() {
    return StartupState();
  }

}

class StartupState extends State<Startup>{
 ConnectifyUser user;
 bool _inAsyncCall = true;
 double milliseconds;
 String time = "";

 @override
  void initState() {
    _loadUser();
    super.initState();
 }

 @override
  void dispose() {
    super.dispose();
  }

 void _launchURL(String url) async {
   if (await canLaunch(url)) {
     await launch(url);
   } else {
     throw 'Could not launch $url';
   }
 }

  void _loadUser()async{
    user = await Provider.of<FirestoreService>(context, listen: false).getUser(widget.uid);
    setState(() {
      _inAsyncCall = false;
   });
  }

  @override
  Widget build(BuildContext context) {
    return _inAsyncCall ? SizedBox() : Container(
        width: MediaQuery.of(context).size.width/1.1,
        // margin: EdgeInsets.only(bottom: 30),
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
        child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 20)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 17,
                    child: FlatButton(
                      child: Text(
                        "Learn More",
                        style: Theme.of(context).textTheme.button.merge(TextStyle(fontSize: 13)),
                      ),
                      color: Theme.of(context).buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10))),
                      onPressed: () {
                        if(widget.link.contains('https://')) _launchURL(widget.link);
                        else _launchURL("https://${widget.link}");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),
              Container(
                decoration: BoxDecoration(
                  image: _inAsyncCall ? null: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(widget.imageUrl)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).buttonColor,
                ),
                width: MediaQuery.of(context).size.width/1.3,
                height: MediaQuery.of(context).size.height/3.5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.description,
                  style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 15)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),
            ]
        )
    );
  }

}