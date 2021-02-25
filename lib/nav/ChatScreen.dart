import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectify/main.dart';
import 'package:connectify/screens/ViewProfileScreen.dart';
import 'package:connectify/services/FirestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

//This is the screen which shows the Global Chat with the messages and TextField -Soham

class ChatPage extends StatefulWidget{

  ChatPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {

  //This is the screen that allows users to chat with each other. Currently, we only have a global chat, but we have the groundwork to implement direct messaging in future.

  ScrollController _scrollController = ScrollController();
  TextEditingController _messageTextController = TextEditingController();

  void dispose() {
    super.dispose();
    _messageTextController.dispose();
    _scrollController.dispose();
  }


  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Global Chat',
          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).buttonColor,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: MessagesStream()),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Theme.of(context).buttonColor, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: Theme.of(context).textTheme.subtitle1,
                      onSubmitted: (s)async{
                        if (_messageTextController.text != "") {
                          await Provider.of<FirestoreService>(context, listen: false).sendMessage({
                            'text': _messageTextController.text,
                            'sender': MyApp.current.username,
                            'timestamp': FieldValue.serverTimestamp(),
                            'uid': MyApp.user.uid,
                          });
                          _messageTextController.clear();
                        }
                      },
                      controller: _messageTextController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                        hintStyle: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10))),
                      color: Theme.of(context).buttonColor,
                      onPressed: () async{
                        if (_messageTextController.text != "")  {
                          await Provider.of<FirestoreService>(context, listen: false).sendMessage({
                            'text': _messageTextController.text.toString(),
                            'sender': MyApp.current.username,
                            'timestamp': FieldValue.serverTimestamp(),
                            'uid': MyApp.user.uid,
                          });
                          _messageTextController.clear();
                        }
                      },
                      child: Text(
                        'Send',
                        style: Theme.of(context).textTheme.button,
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

class MessagesStream extends StatelessWidget {
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<FirestoreService>(context).getChat(),
      builder: (context, snapshot) {
        // flutter's async snapshot
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final messages = snapshot.data.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final uid = message.data()['uid'];
            String timestamp = DateTime.now().toString();
            try{
               timestamp = message.data()['timestamp'].toDate().toString();
            }catch(e){}
            timestamp = timestamp.replaceRange(16, timestamp.length, "");
            var list = timestamp.split(" ");
            int time = int.parse(list[1].split(":")[0]);
            list[1] = time>12 ? "${(12-time).abs()}:${list[1].split(":")[1]}" : "$time:${list[1].split(":")[1]}";
            timestamp= time > 12 ? list[0] + " at " + list[1] + " pm" : list[0] + " at " + list[1] + " am";
            final messageWidget = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: MyApp.current.username == messageSender,
              timestamp: timestamp,
              uid: uid,
              messageId: message.id,
            );
            messageBubbles.add(messageWidget);
          }
          return CupertinoScrollbar(
            controller: _controller,
            child: ListView(
              controller: _controller,
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  final String timestamp;
  final String uid;
  final String messageId;
  MessageBubble({this.text, this.sender, this.isMe, this.timestamp, this.uid, this.messageId});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> !isMe ? Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: ViewProfilePage(uid: uid,))) : showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Delete Message")),
            actions: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      child: Text("No", style: TextStyle(color: Colors.green),),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("Yes", style: TextStyle(color: Colors.red),),
                      onPressed: () async{
                        await Provider.of<FirestoreService>(context, listen: false).deleteChat(messageId);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sender,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Material(
              borderRadius: isMe
                  ? BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0))
                  : BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              elevation: 5.0,
              color: Theme.of(context).buttonColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  '$text',
                  style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(
              timestamp,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}

