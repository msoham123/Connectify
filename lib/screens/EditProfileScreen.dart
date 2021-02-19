import 'dart:io';
import 'package:connectify/services/FirestoreService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:connectify/services/Dropbox.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../main.dart';

class EditProfilePage extends StatefulWidget {

  final String username, description, imageUrl;
  final VoidCallback callback;
  EditProfilePage({@required this.callback, @required this.username, @required this.description, @required this.imageUrl});

  @override
  State<StatefulWidget> createState() {
    return EditProfilePageState();
  }
}

class EditProfilePageState extends State<EditProfilePage> {
  ScrollController _controller = ScrollController();
  TextEditingController description ,
      username;
  DropBox box = DropBox();
  File file;
  bool _inAsyncCall = false;
  bool isImage = true;


  void initState(){
    super.initState();
    description = TextEditingController(text: widget.description);
    username = TextEditingController(text: widget.username);
  }

  void dispose(){
    super.dispose();
  }

  Future _takeImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        file = File(image.path);
        isImage = true;
      });
    }
  }

  Future _pickImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );
    if (result != null) {
      setState(() {
        file = File(result.files.single.path);
        isImage = true;
      });
    }
  }

  void _showPhotoOptions() {
    Dialogs.bottomMaterialDialog(
      color: Theme.of(context).backgroundColor,
      title: 'Pick Image',
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
                  onPressed: () async {
                    _pickImage();
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
            'Edit Profile',
            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.button.color,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
            CupertinoScrollbar(
              controller: _controller,
              child: ListView(
                controller: _controller,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),

                  // file==null ? Center(
                  //   child: GestureDetector(
                  //     onTap: () async{
                  //       _showPhotoOptions();
                  //     },
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(10)),
                  //         color: Colors.green,
                  //       ),
                  //       width: MediaQuery.of(context).size.width/1.2,
                  //       height: MediaQuery.of(context).size.height/4,
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Icon(
                  //             AntDesign.upload,
                  //             color: Theme.of(context).textTheme.button.color,
                  //           ),
                  //           Text("Pick New Image", style: Theme.of(context).textTheme.button,)
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ) :
                  Column(
                    children: [
                      (file==null) ?  Center(
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                      ) : Center(
                        child: Image.file(
                          file,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: FlatButton(
                            disabledColor: Colors.grey,
                            child: Text(
                              "Choose Different Image",
                              style: Theme.of(context).textTheme.button,
                            ),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            onPressed: () async {
                              _showPhotoOptions();
                            }),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),

                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[400],
                      ),
                      width: MediaQuery.of(context).size.width > 800
                          ? MediaQuery.of(context).size.width / 4
                          : MediaQuery.of(context).size.width / 1.2,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: username,
                        style: TextStyle(
                            color: Color(0xFFF234253),
                            fontWeight: FontWeight.bold),
                        obscureText: false,
                        decoration: InputDecoration(
                          icon: IconButton(
                            enableFeedback: false,
                            onPressed: () => null,
                            icon: Icon(AntDesign.profile),
                            color: Colors.blueGrey,
                            hoverColor: Colors.white30,
                          ),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hoverColor: Color(0xFF094074),
                          hintText: "Name",
                          hintStyle: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),

                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[400],
                      ),
                      width: MediaQuery.of(context).size.width > 800
                          ? MediaQuery.of(context).size.width / 4
                          : MediaQuery.of(context).size.width / 1.2,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        maxLines: 10,
                        controller: description,
                        style: TextStyle(
                            color: Color(0xFFF234253),
                            fontWeight: FontWeight.bold),
                        obscureText: false,
                        decoration: InputDecoration(
                          icon: IconButton(
                            enableFeedback: false,
                            onPressed: () => null,
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
                    height: MediaQuery.of(context).size.height / 40,
                  ),

                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.6,
                      height: MediaQuery.of(context).size.height / 18,
                      child: FlatButton(
                        disabledColor: Colors.grey,
                        child: Text(
                          "Update",
                          style: Theme.of(context).textTheme.button,
                        ),
                        color: Theme.of(context).buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))
                        ),
                        onPressed:  (file!=null || username.text!=widget.username || description.text!=widget.description) ? () async{
                          if(file!=null){
                            String path = await box.uploadProfileImage(file);
                            await Provider.of<FirestoreService>(context, listen: false).updateProfileImage(path, MyApp.user.uid);
                          }
                          await Provider.of<FirestoreService>(context, listen: false).updateProfileInfo(username.text, description.text, MyApp.user.uid);
                          widget.callback.call();
                          Navigator.pop(context);
                        } : null,

                      ),

                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
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
