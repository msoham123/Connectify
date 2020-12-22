

import 'package:connectify/services/Dropbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropBoxTest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DropBoxTestState();
  }
}

class DropBoxTestState extends State<DropBoxTest>{

  var list = [];
  DropBox box = DropBox();
  bool _inAsyncCall = true;
  String link;

  @override
  void initState() {
    _loadFiles();
    super.initState();
  }


  void _loadFiles()async{
    link = null;
    await box.loginWithAccessToken();
    var result =  await box.listFolder("");
    setState(() {
      list=result;
      _inAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Center(
            child: FlatButton(
              child: Text("Upload"),
              onPressed: ()async{
                await box.uploadTest();
              },
            ),
          ),
          Center(
            child: FlatButton(
              child: Text("Refresh"),
              onPressed: ()async{
                _loadFiles();
              },
            ),
          ),
          if(_inAsyncCall) Center(child: CircularProgressIndicator(),),
          if(!_inAsyncCall)Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                final filesize = item['filesize'];
                final path = item['pathLower'];
                bool isFile = false;
                var name = item['name'];
                if (filesize == null) {
                  name += '/';
                } else {
                  isFile = true;
                }
                  return ListTile(
                    title: Text(name),
                    onTap: () async {
                      if (isFile) {
                        final link = await box.getTemporaryLink(path);
                        setState(() {
                          this.link = link;
                        });
                        print(link);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text(link)));
                      } else {
                        var result =  await box.listFolder(path);
                        setState(() {
                          list = result;
                        });
                      }
                    });
              },
            ),
          ),
          if(link!=null)Expanded(child: Image.network(link)),
        ],
      ),
    );
  }

}