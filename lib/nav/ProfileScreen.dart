import 'package:connectify/screens/SettingsScreen.dart';
import 'package:connectify/services/DarkNotifier.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../main.dart';
import 'CreatePostScreen.dart';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ScrollController _controller = ScrollController();
  RefreshController _refreshController = RefreshController();
  bool _inAsyncCall = false;


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inAsyncCall,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).buttonColor,
          leading: IconButton(
            icon: Icon(AntDesign.setting, color: Theme.of(context).textTheme.button.color,),
            onPressed: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: SettingsPage()));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(AntDesign.edit, color: Theme.of(context).textTheme.button.color,),
              onPressed: (){
              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).buttonColor,
            ),
            SmartRefresher(
              header: ClassicHeader(
                textStyle: Theme.of(context).textTheme.button,
                failedIcon: Icon(Icons.error, color: Theme.of(context).textTheme.button.color),
                completeIcon: Icon(Icons.done, color: Theme.of(context).textTheme.button.color),
                idleIcon: Icon(Icons.arrow_downward, color: Theme.of(context).textTheme.button.color),
                releaseIcon: Icon(Icons.refresh, color: Theme.of(context).textTheme.button.color),
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              primary: true,
              enablePullDown: true,
              onRefresh: ()async{
                setState(() {
                  _inAsyncCall = true;
                });
                MyApp.current = await Provider.of<FirestoreService>(context, listen: false).getUser(MyApp.user.uid);
                _refreshController.refreshCompleted();
                setState(() {
                  _inAsyncCall = false;
                });
              },
              controller: _refreshController,
              child: CupertinoScrollbar(
                controller: _controller,
                child: ListView(
                  controller: _controller,
                  children: [

                    SizedBox(
                      height: MediaQuery.of(context).size.height/40,
                    ),


                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.1,
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/20),
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
                              width: MediaQuery.of(context).size.width/3,
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height/8,
                                  width: MediaQuery.of(context).size.height/8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover, image: NetworkImage(MyApp.current.image)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Theme.of(context).buttonColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyApp.current.username,
                                    style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height/50,
                                  ),
                                  Text(
                                    '${MyApp.current.school}',
                                    style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 15)),
                                  ),
                                  Text(
                                    '${MyApp.current.followers == null ? 0 : MyApp.current.followers.length} connections',
                                    style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 15)),
                                  ),
                                  Text(
                                    '${MyApp.current.startups == null ? 0 : MyApp.current.startups.length} startups',
                                    style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 15)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height/30,
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/30),
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
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width/30),
                            child: Text(
                              MyApp.current.description,
                              style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 15, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height/50,
                    ),

                    DefaultTabController(
                        length: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/30),
                          child: TabBar(
                            indicatorWeight: 4,
                            indicatorColor: Theme.of(context).buttonColor,
                            unselectedLabelColor: Provider.of<DarkNotifier>(context).isDarkMode ? Colors.white : Colors.black,
                            labelColor: Theme.of(context).textTheme.button.color,
                            tabs: [
                              Tab(text: "Posts", ),
                              Tab(text: "Startups",),
                            ],
                            indicator: RectangularIndicator(
                              topLeftRadius: 10,
                              topRightRadius: 10,
                              bottomLeftRadius: 10,
                              bottomRightRadius: 10,
                              color: Theme.of(context).buttonColor
                            ),
                          ),
                        )
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}