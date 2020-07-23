import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/buttons.dart';
import 'screens/login.dart';
import 'screens/registration.dart';
import 'screens/chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Converse Chat",
      theme: ThemeData.dark(),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        Registration.id: (context) => Registration(),
        Chat.id: (context) => Chat(),
        Login.id: (context) => Login(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  static String id = "HOMESCREEN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  child: Image.asset("assets/index.jpeg"),
                ),
              ),
              Text(
                "Converse Chat",
                style: TextStyle(
                  fontSize: 40.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          CustomButton(
              callback: () {Navigator.of(context).pushNamed(Login.id);},
              text: "Log In"),
          SizedBox(
            height: 20.0,
          ),
          CustomButton(callback: () {Navigator.of(context).pushNamed(Registration.id);}, text: "Register"),
        ],
      ),
    );
  }
}
