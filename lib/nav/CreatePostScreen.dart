
import 'dart:io';
import 'package:connectify/services/FirestoreService.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:connectify/models/ConnectifyPost.dart';
import 'package:connectify/services/Dropbox.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

class CreatePostPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CreatePostPageState();
  }
}

class CreatePostPageState extends State<CreatePostPage>{

  ScrollController _controller = ScrollController();
  TextEditingController description = TextEditingController(), hashtags = TextEditingController();
  DropBox box = DropBox();
  File file;
  bool _inAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inAsyncCall,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: CupertinoScrollbar(
          controller: _controller,
          child: ListView(
            controller: _controller,
            children: [


              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/8,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: IconButton(
                          icon: Icon(AntDesign.arrowleft, color: Theme.of(context).buttonColor,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/8,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                       'Create Post',
                        style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),

              file==null ? Center(
                child: GestureDetector(
                  onTap: () async{
                    FilePickerResult result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                    );
                    if(result != null) {
                      setState(() {
                        file = File(result.files.single.path);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.green,
                    ),
                    width: MediaQuery.of(context).size.width/1.2,
                    height: MediaQuery.of(context).size.height/4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          AntDesign.upload,
                          color: Theme.of(context).textTheme.button.color,
                        ),
                        Text("Pick Image/Video", style: Theme.of(context).textTheme.button,)
                      ],
                    ),
                  ),
                ),
              ) : Column(
                children: [

                  Center(
                    child: Image.file(file, fit: BoxFit.cover,  width: MediaQuery.of(context).size.width/1.2,
                      height: MediaQuery.of(context).size.height/4,),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height/40,
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width/1.2,
                    child: FlatButton(
                      disabledColor: Colors.grey,
                      child: Text("Choose Different Image/Video", style: Theme.of(context).textTheme.button,),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      onPressed: ()async{
                        FilePickerResult result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );
                        if(result != null) {
                          file = File(result.files.single.path);

                        } else {
                          // User canceled the picker
                        }
                      }),
                  ),

                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[400],
                  ),
                  width: MediaQuery.of(context).size.width>800 ? MediaQuery.of(context).size.width/4 :  MediaQuery.of(context).size.width/1.2,
                  child: TextField(
                    controller: description,
                    style: TextStyle(
                        color: Color(0xFFF234253),
                        fontWeight: FontWeight.bold),
                    obscureText: false,
                    decoration: InputDecoration(
                      icon: IconButton(
                        enableFeedback: false,
                        onPressed: ()=>null,
                        icon: Icon(AntDesign.filetext1),
                        color: Colors.blueGrey,
                        hoverColor: Colors.white30,
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      hoverColor: Color(0xFF094074),
                      hintText: "Description",
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[400],
                  ),
                  width: MediaQuery.of(context).size.width>800 ? MediaQuery.of(context).size.width/4 :  MediaQuery.of(context).size.width/1.2,
                  child: TextField(
                    controller: description,
                    style: TextStyle(
                        color: Color(0xFFF234253),
                        fontWeight: FontWeight.bold),
                    obscureText: false,
                    decoration: InputDecoration(
                      icon: IconButton(
                        enableFeedback: false,
                        onPressed: ()=>null,
                        icon: Icon(AntDesign.filetext1),
                        color: Colors.blueGrey,
                        hoverColor: Colors.white30,
                      ),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      hoverColor: Color(0xFF094074),
                      hintText: "Hashtags",
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height/40,
              ),

              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.6,
                  height: MediaQuery.of(context).size.height/18,
                  child: FlatButton(
                    disabledColor: Colors.grey,
                    child: Text("Create", style: Theme.of(context).textTheme.button,),
                    color: Theme.of(context).buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    onPressed: file!=null && description.text!=null && description.text.length>5 ? () async{
                      if(file != null) {
                        setState(() {
                          _inAsyncCall = true;
                        });
                        String path = await box.uploadPostImage(file);
                        print(path);
                        ConnectifyPost post = ConnectifyPost(
                          uid: MyApp.user.uid,
                          description: description.text,
                          path: path,
                          comments: {},
                          stars: [],
                          datePublished: DateTime.now(),
                          hashtags: hashtags.text,
                        );
                        Uuid id = Uuid();
                        String postId = id.v4();
                        bool result = await Provider.of<FirestoreService>(context, listen: false).createPost(postId, post);
                        setState(() {
                          _inAsyncCall=false;
                        });
                        if(result){
                          Navigator.pop(context);
                        }else{
                          Dialogs.materialDialog(
                            msg: 'Could not create post. Please try again!',
                            title: "Error",
                            color: Colors.white,
                            context: context,
                            singleBtn: true,
                            btn1Press: ()=> Navigator.pop(context),
                            btn1Bcg: Theme.of(context).buttonColor,
                            btnShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            btn1Text: 'Close',
                            btn2Press: ()=>null,
                            btn2Text: '',
                          );
                        }

                      }
                    } : null,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}