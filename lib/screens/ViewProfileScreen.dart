import 'package:connectify/main.dart';
import 'package:connectify/models/ConnectifyUser.dart';
import 'package:connectify/services/DarkNotifier.dart';
import 'package:connectify/services/Dropbox.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ViewProfilePage extends StatefulWidget {
  final String uid;

  ViewProfilePage({@required this.uid});

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  ScrollController _controller = ScrollController();
  RefreshController _refreshController = RefreshController();
  bool _inAsyncCall = true;
  List<Widget> _postList = [], _startupList = [];
  int _index = 0;
  DropBox box = DropBox();
  ConnectifyUser _user;

  void initState() {
    super.initState();
      loadData();
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
    _refreshController.dispose();
  }

  Future<void> loadData() async {
    await box.loginWithAccessToken();
    await box.listFolder("");
    _user = await Provider.of<FirestoreService>(context, listen: false).getUser(widget.uid);
    _user.image = await box.getTemporaryLink(_user.image);
    _postList.clear();
    _startupList.clear();
    _postList = await Provider.of<FirestoreService>(context, listen: false).getProfilePosts(_user.posts,  MediaQuery.of(context).size.height/20);
    _startupList = await Provider.of<FirestoreService>(context, listen: false).getProfileStartups(_user.startups, MediaQuery.of(context).size.height / 20);
    Future.delayed(Duration(seconds: 2));
    setState(() {
      _inAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'View Profile',
          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).buttonColor,
        automaticallyImplyLeading: true,
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
          if(_inAsyncCall) Center(child: CircularProgressIndicator(),),
          if(!_inAsyncCall)CupertinoScrollbar(
            controller: _controller,
            child: SmartRefresher(
              scrollController: _controller,
              header: ClassicHeader(
                textStyle: Theme.of(context).textTheme.button,
                failedIcon: Icon(Icons.error,
                    color: Theme.of(context).textTheme.button.color),
                completeIcon: Icon(Icons.done,
                    color: Theme.of(context).textTheme.button.color),
                idleIcon: Icon(Icons.arrow_downward,
                    color: Theme.of(context).textTheme.button.color),
                releaseIcon: Icon(Icons.refresh,
                    color: Theme.of(context).textTheme.button.color),
              ),
              // physics: const AlwaysScrollableScrollPhysics(),
              // primary: true,
              enablePullDown: true,
              onRefresh: () async {
                setState(() {
                  _inAsyncCall = true;
                });
                loadData();
                _refreshController.refreshCompleted();
              },
              controller: _refreshController,
              child: ListView(
                // primary: false,
                shrinkWrap: false,
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Center(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    width: MediaQuery.of(context).size.height / 8,
                                    decoration: BoxDecoration(
                                      image: _user.image == null ? null :DecorationImage(
                                          fit: BoxFit.cover,
                                          image:  NetworkImage(_user.image)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Theme.of(context).buttonColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _user.username,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .merge(TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height / 50,
                                    ),
                                    Text(
                                      '${_user.school}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .merge(TextStyle(fontSize: 15)),
                                    ),
                                    Text(
                                      '${_user.followers == null ? 0 : _user.followers.length} connections',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .merge(TextStyle(fontSize: 15)),
                                    ),
                                    Text(
                                      '${_user.startups == null ? 0 : _user.startups.length} startups',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .merge(TextStyle(fontSize: 15)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          if(widget.uid != MyApp.user.uid )SizedBox(
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: MediaQuery.of(context).size.height / 14,
                            child: FlatButton(
                              child: Text(
                                MyApp.current.following.contains(widget.uid)? "Disconnect" : "Connect",
                                style: Theme.of(context).textTheme.button,
                              ),
                              color: Theme.of(context).buttonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))),
                              onPressed: () async {
                                Provider.of<FirestoreService>(context,listen: false).connect(widget.uid);
                                if(MyApp.current.following.contains(widget.uid)){
                                  setState(() {
                                    _user.followers.remove(MyApp.user.uid);
                                    MyApp.current.following.remove(widget.uid);
                                  });
                                }else{
                                  setState(() {
                                    _user.followers.add(MyApp.user.uid);
                                    MyApp.current.following.add(widget.uid);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).buttonColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 30),
                          child: Text(
                            _user.description,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .merge(TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  DefaultTabController(
                      length: 2,
                      initialIndex: _index,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 30),
                        child: TabBar(
                          indicatorWeight: 4,
                          indicatorColor: Theme.of(context).buttonColor,
                          unselectedLabelColor:
                              Provider.of<DarkNotifier>(context).isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                          labelColor:
                              Theme.of(context).textTheme.button.color,
                          tabs: [
                            Tab(
                              text: "Posts",
                            ),
                            Tab(
                              text: "Startups",
                            ),
                          ],
                          onTap: (value) {
                            setState(() {
                              _index = value;
                            });
                          },
                          indicator: RectangularIndicator(
                              topLeftRadius: 10,
                              topRightRadius: 10,
                              bottomLeftRadius: 10,
                              bottomRightRadius: 10,
                              color: Theme.of(context).buttonColor),
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  if (_inAsyncCall == false && _index == 0)
                    Column(
                      children: _postList,
                    ),
                  if (_inAsyncCall == false && _index == 1)
                    Column(
                      children: _startupList,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
