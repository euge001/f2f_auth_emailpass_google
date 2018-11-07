import 'package:flutter/material.dart';
import 'auth.dart';


class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: new Color(0xFF000000),
          title:  Image.asset(
            'assets/images/logo.png',
            height: 30.0,
            fit: BoxFit.fill,
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 24.0, color: Colors.white)),
              onPressed: () {
                _signOut();
              },
            )
          ],
        ),
        body: new Container(
    decoration: BoxDecoration(
              color: Colors.white30,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.colorDodge),
                image: AssetImage('assets/images/cabin.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
        ));

//    return new Scaffold(
//        body: new Container(
//            decoration: BoxDecoration(
//              color: Colors.white30,
//              image: DecorationImage(
//                colorFilter: new ColorFilter.mode(
//                    Colors.black.withOpacity(0.2), BlendMode.colorDodge),
//                image: AssetImage('assets/images/cabin.png'),
//                fit: BoxFit.fitHeight,
//              ),
//            ),
//            child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: [
//                  Image.asset(
//                    'assets/images/logo.png',
//                    height: 70.0,
//                    fit: BoxFit.fill,
//                  ),
//                  Form(
//                    key: formKey,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: buildInputs() + buildButtons(),
//                    ),
//                  ),
//                ])));

  }
}
