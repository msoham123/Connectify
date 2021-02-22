import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:image_picker/image_picker.dart';
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
  bool isImage = true;

  Future _takeVideo() async {
    var image = await ImagePicker().getVideo(source: ImageSource.camera);
    if(image != null) {
      setState(() {
        file = File(image.path);
        isImage = false;
      });
    }
  }

  Future _takeImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    if(image != null) {
      setState(() {
        file = File(image.path);
        isImage = true;
      });
    }
  }

  Future _pickVideo() async{
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowCompression: true,
    );
    if(result != null) {
      setState(() {
        file = File(result.files.single.path);
        isImage = false;
      });
    }
  }

  Future _pickImage()async{
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );
    if(result != null) {
      setState(() {
        file = File(result.files.single.path);
        isImage = true;
      });
    }
  }


  void _showPhotoOptions() {
    Dialogs.bottomMaterialDialog(
        color: Theme.of(context).backgroundColor,
        title: 'Pick Image/Video',
        context: context,
        msg: '',
        actions: [
          Column(
            children: <Widget>[
              Column(
                children: [
                  FlatButton(
                    textColor: Colors.black,
                    child: Text("Take Image",
                        style: Theme.of(context).textTheme.headline1),
                    onPressed: () {
                      _takeImage();
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    textColor: Colors.black,
                    child: Text("Pick Image",
                        style: Theme.of(context).textTheme.headline1),
                    onPressed: () async{
                      _pickImage();
                      Navigator.pop(context);
                    },
                  ),
                  // FlatButton(
                  //   textColor: Colors.black,
                  //   child: Text("Take Video",
                  //       style: Theme.of(context).textTheme.headline1),
                  //   onPressed: () {
                  //     _takeVideo();
                  //     Navigator.pop(context);
                  //   },
                  // ),
                  FlatButton(
                    textColor: Colors.black,
                    child: Text("Pick Video",
                        style: Theme.of(context).textTheme.headline1),
                    onPressed: () async{
                      _pickVideo();
                      Navigator.pop(context);
                    },
                  ),

                  FlatButton(
                    color: Colors.red,
                    textColor: Colors.black,
                    child: Text("Close",
                        style: Theme.of(context).textTheme.headline1),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],

    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inAsyncCall,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Create Post',
            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).textTheme.button.color,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).buttonColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).buttonColor,
            ),
            CupertinoScrollbar(
              controller: _controller,
              child: ListView(
                controller: _controller,
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.height/40,
                  ),

                  file==null ? Center(
                    child: GestureDetector(
                      onTap: () async{
                        _showPhotoOptions();
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

                      isImage ? Center(
                        child: Image.file(file, fit: BoxFit.cover,  width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.height/4,),
                      ): BetterPlayer.file(file.path, betterPlayerConfiguration: BetterPlayerConfiguration(
                        aspectRatio: 16 / 9,
                      ),),

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
                           _showPhotoOptions();
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
                        keyboardType: TextInputType.text,
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
                        keyboardType: TextInputType.text,
                        controller: hashtags,
                        style: TextStyle(
                            color: Color(0xFFF234253),
                            fontWeight: FontWeight.bold),
                        obscureText: false,
                        decoration: InputDecoration(
                          icon: IconButton(
                            enableFeedback: false,
                            onPressed: ()=>null,
                            icon: Icon(FontAwesome.hashtag),
                            color: Colors.blueGrey,
                            hoverColor: Colors.white30,
                          ),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hoverColor: Color(0xFF094074),
                          hintText: "#Connectify, #2021",
                          labelText: "Hashtags",
                          labelStyle: Theme.of(context).textTheme.subtitle2,
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
                        onPressed: file!=null && description.text!=null && description.text.length>5  ? () async{
                          if(file != null) {
                            setState(() {
                              _inAsyncCall = true;
                            });
                            String path = await box.uploadPostImage(file);
                            ConnectifyPost post = ConnectifyPost(
                              uid: MyApp.user.uid,
                              description: description.text,
                              path: path,
                              comments: {},
                              stars: [],
                              datePublished: DateTime.now(),
                              hashtags: hashtags.text,
                              isImage: isImage
                            );
                            Uuid id = Uuid();
                            String postId = id.v4();
                            bool result = await Provider.of<FirestoreService>(context, listen: false).createPost(postId, post);
                            await Provider.of<FirestoreService>(context, listen: false).addPostToProfile(MyApp.user.uid, postId, MyApp.current.posts);
                            setState(() {
                              _inAsyncCall=false;
                            });
                            if(result){
                              Navigator.pop(context);
                            }else{
                              Dialogs.materialDialog(
                                msg: 'Could not create post. Please try again.',
                                title: "Error",
                                color: Colors.white,
                                context: context,
                                actions: [
                                  FlatButton(
                                    child: Text("Close", style: Theme.of(context).textTheme.button,),
                                    color: Theme.of(context).buttonColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    onPressed: ()=> Navigator.pop(context),
                                  ),
                                ]
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
          ],
        ),
      ),
    );
  }

}