import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  const CustomButton({this.callback,this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.teal[300],
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200,
          height: 45.0,
          child: Text(text),
        ),
      ),
    );
  }
}
class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: callback,
      color: Colors.teal[300],
      child: Text(text),
    );
  }
}
