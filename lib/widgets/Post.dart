import 'dart:math';
import 'package:better_player/better_player.dart';
import 'package:connectify/main.dart';
import 'package:connectify/models/ConnectifyUser.dart';
import 'package:connectify/screens/ViewProfileScreen.dart';
import 'package:connectify/services/Dropbox.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Post extends StatefulWidget{

  final String description, uid, imageUrl, hashtags, postId;
  final Map<String, String> comments;
  final List<String> stars;
  // final ScrollController _controller = ScrollController();
  final DateTime datePublished;
  final bool isImage;


  Post({this.description,this.uid, this.imageUrl, this.comments, this.stars, this.datePublished,this.hashtags, this.postId, this.isImage});


  @override
  State<StatefulWidget> createState() {
    return PostState();
  }

}

class PostState extends State<Post>{

  //Frontend UI Component that displays the values obtained by ConnectifyPost

 ConnectifyUser user;
 bool _inAsyncCall = true;
 double milliseconds;
 String time = "";
 BetterPlayerController _betterPlayerController;
 DropBox box = DropBox();


 @override
  void initState() {
    _loadUser();
    if(!widget.isImage){
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          widget.imageUrl);
      _betterPlayerController = BetterPlayerController(BetterPlayerConfiguration(
        aspectRatio: 3/2,

      ),
          betterPlayerDataSource: betterPlayerDataSource);
    }
    super.initState();
 }

 @override
  void dispose() {
   if(!widget.isImage) _betterPlayerController.dispose();
    super.dispose();
  }


  void _loadUser()async{
    await box.loginWithAccessToken();
    await box.listFolder("");
    user = await Provider.of<FirestoreService>(context, listen: false).getUser(widget.uid);
    user.image = await box.getTemporaryLink(user.image);
    milliseconds = (DateTime.now().millisecondsSinceEpoch-widget.datePublished.millisecondsSinceEpoch)+0.0;
    time = milliseconds<60000 ? '${(milliseconds/1000).ceil()} seconds ago' : milliseconds < (3.6 * pow(10, 6)) ?
    '${(milliseconds/60000).ceil()} minutes ago' : milliseconds<(8.64 * pow(10, 7)) ?
    '${(milliseconds/(3.6 * pow(10, 6))).ceil()} hours ago' : milliseconds<(2.628 * pow(10, 9)) ?
    '${(milliseconds/(8.64 * pow(10, 7))).ceil()} days ago' : milliseconds<(3.154 * pow(10, 10)) ?
    '${(milliseconds/(2.628 * pow(10, 9))).ceil()} weeks ago' : '${(milliseconds/(3.154 * pow(10, 10))).ceil()} days ago';
    if(milliseconds<60000){
      time = '${(milliseconds/1000).ceil()} seconds ago';
    }else if( milliseconds < (3.6 * pow(10, 6))){
      time = '${(milliseconds/60000).ceil()} minutes ago';
    }else if (milliseconds<(8.64 * pow(10, 7))){
      time = '${(milliseconds/(3.6 * pow(10, 6))).ceil()} hours ago';
    }else if (milliseconds<(2.628 * pow(10, 9))) {
      time = '${(milliseconds/(8.64 * pow(10, 7))).ceil()} days ago';
    }else if (milliseconds<(3.154 * pow(10, 10))){
      time = '${(milliseconds/(2.628 * pow(10, 9))).ceil()} weeks ago';
    }else time = '${(milliseconds/(3.154 * pow(10, 10))).ceil()} days ago';
    setState(() {
      _inAsyncCall = false;
   });
  }

  @override
  Widget build(BuildContext context) {
    return _inAsyncCall ? SizedBox() : GestureDetector(
      onDoubleTap: (){

      },
      child: Container(
          height: MediaQuery.of(context).size.height/1.7,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/20,
                      ),
                      GestureDetector(
                        onTap: ()=> Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: ViewProfilePage(uid: widget.uid))),
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height/15,
                            width: MediaQuery.of(context).size.height/15,
                            decoration: BoxDecoration(
                              image: _inAsyncCall ? null: DecorationImage(
                                  fit: BoxFit.cover, image: NetworkImage(user.image)),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Theme.of(context).buttonColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/20,
                      ),
                      Column(
                        children: [
                          Text(user.username,
                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              time,
                              style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 15,)),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child:  IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Icon(AntDesign.sharealt, color: Theme.of(context).textTheme.subtitle1.color,),
                              onPressed: (){
                                Share.share('Check out my cool post on Connectify!', subject: 'Look what I posted!');
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/40,
                ),
                widget.isImage ? Container(
                  decoration: BoxDecoration(
                    image: _inAsyncCall ? null: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(widget.imageUrl)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).buttonColor,
                  ),
                  width: MediaQuery.of(context).size.width/1.3,
                  height: MediaQuery.of(context).size.height/3.5,
                ): Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).buttonColor,
                  ),
                  width: MediaQuery.of(context).size.width/1.3,
                  height: MediaQuery.of(context).size.height/3.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BetterPlayer(
                      controller: _betterPlayerController,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/30,
                ),
                if(widget.hashtags!=null && widget.hashtags!="")Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/15),
                    child: Text(
                      widget.hashtags,
                      style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 13, color: Colors.blue)),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/40,
                      ),
                      FlatButton(
                        padding: null,
                        child: Row(
                          children: [
                            Icon(AntDesign.star, color: widget.stars.contains(MyApp.user.uid) ? Theme.of(context).buttonColor : Colors.blueGrey,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/40,
                            ),
                            Text(
                              widget.stars!=null ? widget.stars.length.toString() : '0',
                              style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 15)),
                            ),
                          ],
                        ),
                        onPressed: widget.stars.contains(MyApp.user.uid) ? ()async{
                          setState(() {
                            widget.stars.remove(MyApp.user.uid);
                          });
                          await Provider.of<FirestoreService>(context, listen: false).incrementStar(widget.postId, widget.stars);
                        }: ()async{
                          setState(() {
                            widget.stars.add(MyApp.user.uid);
                          });
                          await Provider.of<FirestoreService>(context, listen: false).incrementStar(widget.postId, widget.stars);
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/25),
                          child: Text(
                            widget.description,
                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 15)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/40,
                ),
              ]
          )
      ),
    );
  }

}