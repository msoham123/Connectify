

import 'dart:io';
import 'package:connectify/models/ConnectifyPost.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/nav/CreatePostScreen.dart';
import 'package:connectify/services/Dropbox.dart';
import 'package:connectify/widgets/Post.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{

  DropBox box = DropBox();
  bool _inAsyncCall = true;
  ScrollController _controller = ScrollController();
  List<Widget> list = [];
  RefreshController _refreshController = RefreshController();


  @override
  void initState() {
    _loadData();
    super.initState();
  }


  void _loadData()async{
    list = [];
    await box.loginWithAccessToken();
    await box.listFolder("");
    List<ConnectifyPost> temp = await Provider.of<FirestoreService>(context, listen: false).getPosts();
    for(ConnectifyPost post in temp){
      list.add(
          Post(
            description: post.description,
            uid: post.uid,
            imageUrl: await box.getTemporaryLink(post.path),
            stars: post.stars,
            comments: post.comments,
            datePublished: post.datePublished,
            hashtags: post.hashtags,
          )
      );
      list.add(SizedBox(height: MediaQuery.of(context).size.height/20,));
    }
    setState(() {
      _inAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).buttonColor,
        actions: [
          IconButton(
            icon: Icon(AntDesign.plus, color: Colors.white,),
            onPressed: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: CreatePostPage()));
            },
          ),
        ],
      ),
      body:   Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/6,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).buttonColor,
          ),

          SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: ()async{
              setState(() {
                _inAsyncCall = true;
              });
              _loadData();
              _refreshController.refreshCompleted();
            },
            child: CupertinoScrollbar(
              controller: _controller,
              child: ListView(
                controller: _controller,
                children: [



                  SizedBox(height: MediaQuery.of(context).size.height/20,),


                  !_inAsyncCall ? Column(
                    children: list,
                  ) : Center(child: CircularProgressIndicator()),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }





}