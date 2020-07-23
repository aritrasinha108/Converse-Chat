import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/chat.dart';
import '../widgets/buttons.dart';


class Login extends StatefulWidget {
  static String id="LOGIN";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Chat(user: user,)

    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Converse Chat"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('assets/index.jpeg'),
              ),
            ),

          ),
          SizedBox(height: 40.0,),
          TextField(decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder()
          ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Enter Password",
                  border: OutlineInputBorder()
              ),

              onChanged: (value) => password = value
          ),
          SizedBox(height: 20.0),
          CustomButton(callback: () async {
            await loginUser();
          },
            text: "Login",)
        ],
      ),
    );
  }
}
