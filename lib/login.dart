library login;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatefulWidget {
  Login({
    @required this.loggedIn,
    @required this.loggedOut
  });

  final Widget loggedIn;
  final Widget loggedOut;

  static var currentUser;
  static var isLoggedIn = false;

  static Future<bool> checkLogin(FirebaseUser user) async {
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);
  }

  static Future<FirebaseUser> signInWithEmail(String email, String password) async {
    try {
      final AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = result.user;

      await checkLogin(user);

      return user;
    } catch(e) {
      debugPrint("Error: $e");
    }
  }

  static Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      await checkLogin(user);

      return user;
    } catch(e) {
      debugPrint("Error: $e");
    }

  }

  static Future signOut() {
    return FirebaseAuth.instance.signOut();
  }

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _instance = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    try {
      _instance.onAuthStateChanged.listen((FirebaseUser firebaseUser) {
        setState(() {
          Login.currentUser = firebaseUser;
          Login.isLoggedIn = firebaseUser != null;
        });
      });
    } catch(e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Login.isLoggedIn ? widget.loggedIn : widget.loggedOut;
  }
}

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 8,
      splashColor: Colors.grey,
      color: Colors.white,
      onPressed: Login.signInWithGoogle,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google.png", package: "login"), height: 18),
            Container(width: 24.0,),
            Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}