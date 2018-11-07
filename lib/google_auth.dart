import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();


class MyApp2 extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp2> {

  String _status;


  @override
  void initState() {
    _status = 'Not Authenticated';
  }

  void _signInAnon() async {
    FirebaseUser user = await _auth.signInAnonymously();
    if(user != null && user.isAnonymous == true) {
      setState(() {
        _status = 'Signed in Anonymously';
      });
    } else {
      setState(() {
        _status = 'Sign in failed!';
      });
    }
  }

  void _signInGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final FirebaseUser user = await _auth.signInWithGoogle(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    if(user != null && user.isAnonymous == false) {
      setState(() {
        _status = 'Signed in with Google';
      });
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()));

    } else {
      setState(() {
        _status = 'Google Signin Failed';
      });
    }
  }

  void _signOut() async {
    await _auth.signOut();
    setState(() {
      _status = 'Signed out';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text(_status),
                new RaisedButton(onPressed: _signOut, child: new Text('Sign out'),),
                new RaisedButton(onPressed: _signInAnon, child: new Text('Sign in Anon'),),
                new RaisedButton(onPressed: _signInGoogle, child: new Text('Sign in Google'),),
              ],
            );
  }
}