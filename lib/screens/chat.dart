import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/buttons.dart';
import '../widgets/message.dart';
class Chat extends StatefulWidget {
  static String id="CHAT";
  final FirebaseUser user;

  const Chat({Key key, this.user}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final Firestore _firestore=Firestore.instance;
  TextEditingController messageController=TextEditingController();
  ScrollController scrollController=ScrollController();
  Future<void> callBack() async{
    var now=DateTime.now();
    if(messageController.text.length>0){
      await _firestore.collection('messages').add({
        'text':messageController.text,
        'from':widget.user.email,
        'at': now
      });
      messageController.clear();
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40.0,
            child: Image.asset('assets/index.jpeg'),
          ),
        ),
        title: Text("Converse Chat"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close,),
            onPressed: (){
            _auth.signOut();
            Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context,snapshot){
                if(!snapshot.hasData)return Center(child: CircularProgressIndicator());
                List<DocumentSnapshot> docs=snapshot.data.documents;
                docs.sort((a,b){
                  var r=a.data['at'].compareTo(b.data['at']);
                  if(r!=0)
                    return r;
                  else
                    return a.data['from'].compareTo(b.data['from']);
                });
                List <Widget> messages= docs.map((doc) => Message(from: doc.data['from'],text: doc.data['text'],me: widget.user.email==doc.data['from'],at: doc.data['at'],)).toList();

                return ListView(
                  controller: scrollController,
                  children: <Widget>[
                    ...messages,
                  ],
                );},
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: "Enter your message..",
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  SendButton(callback: callBack, text: "Send",)

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
