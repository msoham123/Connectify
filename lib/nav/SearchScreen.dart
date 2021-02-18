import 'package:connectify/services/DarkNotifier.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:connectify/widgets/Post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController _controller = ScrollController();
  TextEditingController _search = TextEditingController();
  bool _inAsyncCall = false;
  int _index = 0;
  List<Widget> _postList = [];

  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).buttonColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).buttonColor,
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Theme.of(context).buttonColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: TextField(
                  onSubmitted: (value) {
                    if(_index==0){
                      if(_search.value.text == null || _search.value.text == '') return null;
                      else{
                        getPostSearch(_search.value.text);
                      }
                    }
                  },
                  controller: _search,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Theme.of(context).buttonColor,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    // surffix isn't working properly  with SVG
                    // thats why we use row
                    suffixIcon: Icon(Icons.search, color: Theme.of(context).buttonColor,),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              ),
              Expanded(
                child: CupertinoScrollbar(
                  controller: _controller,
                  child: ListView(
                    controller: _controller,
                    children: [

                      DefaultTabController(
                          length: 2,
                          initialIndex: _index,
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
                              onTap: (value){
                                setState(() {
                                  _index = value;
                                });
                              },
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

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),

                      if(_inAsyncCall) Center(child: CircularProgressIndicator()),

                      if(!_inAsyncCall && _index==0) (_postList.length==0) ? Center(child: Text("No Posts Found")) : Column(children: _postList,)


                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void getPostSearch (String search) async{
    setState(() {
      _inAsyncCall = true;
    });
    _postList = [];
    if(search!=""){
      _postList = await Provider.of<FirestoreService>(context, listen: false).getPostSearch(search, MediaQuery.of(context).size.height/20,);
    }
    setState(() {
      _inAsyncCall = false;
    });
  }

}
