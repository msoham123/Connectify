import 'package:connectify/services/FirestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../main.dart';



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
        backgroundColor: Theme.of(context).backgroundColor,
        body: SmartRefresher(
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

                // SizedBox(
                //   height: MediaQuery.of(context).size.height/20,
                // ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: IconButton(
                      icon: Icon(AntDesign.edit, color: Theme.of(context).buttonColor,),
                      onPressed: (){

                      },
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.height/8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(MyApp.current.image)),
                            // borderRadius: BorderRadius.all(Radius.circular(10)),
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

                SizedBox(
                  height: MediaQuery.of(context).size.height/30,
                ),

                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/30),
                    child: Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).buttonColor,
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
                        labelColor: Theme.of(context).buttonColor,
                        tabs: [
                          Tab(text: "Posts", ),
                          Tab(text: "Startups",),
                        ],
                      ),
                    )
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

}