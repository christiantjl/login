import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login/login.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Example",
      home: Scaffold(
          body: Login(
            loggedIn: myHomePage(),
            loggedOut: myLoginForm(),
          )
      ),
    );
  }
}

class myHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("You're logged in!"),
    );
  }
}

class myLoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("You're not logged in! \n\n Sign in won't actually work on this page because Firebase is not set up, but it does illustrate how the package works out of the box. Tap the button to try it out! \n\n If FirebaseAuth received a login update containing a non-null FirebaseUser, this page would automatically refresh to show myHomePage().", textAlign: TextAlign.center,),
          ),
          GoogleSignInButton()
        ]
      )
    );
  }
}
