import 'package:connectify/models/ConnectifyStartup.dart';
import 'package:connectify/screens/CreateStartupScreen.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:connectify/widgets/Startup.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:connectify/services/Dropbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StartupPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StartupPageState();
  }
}

class StartupPageState extends State<StartupPage>{

  //This is the screen that shows users startups. They can also access the create startup screen from here.

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

  @override
  void dispose() {
    _controller.dispose();
    _refreshController.dispose();
    super.dispose();
  }


  void _loadData()async{
    list = [];
    await box.loginWithAccessToken();
    await box.listFolder("");
    var temp = await Provider.of<FirestoreService>(context, listen: false).getStartups();
    List<ConnectifyStartup> newList = temp[0];
    List<String> idList = temp[1];
    for(int i = 0; i<newList.length;i++){
      list.add(
          Startup(
            description: newList[i].description,
            uid: newList[i].uid,
            imageUrl: await box.getTemporaryLink(newList[i].path),
            comments: newList[i].comments,
            title: newList[i].title,
            startupId: idList[i],
            link: newList[i].link,
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
          'Startup',
          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).buttonColor,
        actions: [
          IconButton(
            icon: Icon(AntDesign.plus, color: Colors.white,),
            onPressed: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: CreateStartupPage()));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/6,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).buttonColor,
          ),
          CupertinoScrollbar(
            controller: _controller,
            child: SmartRefresher(
              header: ClassicHeader(
                textStyle: Theme.of(context).textTheme.button,
                failedIcon: Icon(Icons.error, color: Theme.of(context).textTheme.button.color),
                completeIcon: Icon(Icons.done, color: Theme.of(context).textTheme.button.color),
                idleIcon: Icon(Icons.arrow_downward, color: Theme.of(context).textTheme.button.color),
                releaseIcon: Icon(Icons.refresh, color: Theme.of(context).textTheme.button.color),
              ),
              controller: _refreshController,
              enablePullDown: true,
              onRefresh: ()async{
                setState(() {
                  _inAsyncCall = true;
                });
                _loadData();
                _refreshController.refreshCompleted();
              },
              child: !_inAsyncCall ? ListView(
                primary: false,
                physics: BouncingScrollPhysics(),
                controller: _controller,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/40),
                    child: Column(
                      children: list,
                    ),
                  ),
                ],
              ): Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }





}