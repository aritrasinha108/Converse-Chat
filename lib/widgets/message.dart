import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String text;
  final bool me;

  final dynamic at;

  const Message({Key key, this.from, this.text, this.me,this.at}) : super(key: key);


  @override
    Widget build(BuildContext context) {

    return Container(
      child: Column(
        crossAxisAlignment: me?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: <Widget>[
          Text(from),
          Material(color: me?Colors.teal[300]:Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          elevation: 6.0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child: Text(text,
            style: TextStyle(
              color: !me?Colors.black:Colors.black
            ),),
          ),)
        ],
      ),
    );
  }
}
