import 'package:flutter/material.dart';
import 'package:login_demo/auth/auth_provider.dart';
//import 'package:login_demo/auth/google_auth.dart';
//import 'google_auth.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        var auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          String userId =
              await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          String userId =
              await auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 70.0,
                    fit: BoxFit.fill,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildInputs() + buildSubmitButtons(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(32.0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: buildGoogleButtons(),
                    ),
                  ),
                ])));
  }

  List<Widget> buildInputs() {
    return [
      //Enter your email field
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
            width: 1.0,
          ),
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Icon(
                Icons.person_outline,
                color: Colors.black,
              ),
            ),
            Container(
              //разделитель между значком и текстом
              height: 30.0,
              width: 1.0,
              color: Colors.black.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),
            new Expanded(
              child: TextFormField(
                key: Key('email'),
                validator: EmailFieldValidator.validate,
                onSaved: (value) => _email = value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),

//Enter your password field
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white.withOpacity(0.85),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Icon(
                Icons.lock_open,
                color: Colors.black,
              ),
            ),
            Container(
              //разделитель между значком и текстом
              height: 30.0,
              width: 1.0,
              color: Colors.black.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),
            new Expanded(
              child: TextFormField(
                key: Key('password'),
                obscureText: true,
                validator: PasswordFieldValidator.validate,
                onSaved: (value) => _password = value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          color: Colors.orange,
          padding: const EdgeInsets.all(12.0),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          key: Key('signIn'),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Login', style: TextStyle(fontSize: 20.0)),
              ]),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Create an account', style: TextStyle(fontSize: 20.0)),
          ]),
          textColor: Colors.white,
          padding: const EdgeInsets.all(18.0),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        RaisedButton(
          color: Colors.orange,
          padding: const EdgeInsets.all(12.0),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          key: Key('signIn'),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Create an account', style: TextStyle(fontSize: 20.0)),
              ]),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
          ]),
          textColor: Colors.white,
          padding: const EdgeInsets.all(18.0),
          onPressed: moveToLogin,
        ),
      ];
    }
  }

  List<Widget> buildGoogleButtons() {
    return [
//      GoogleAuth(),
      RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        color: Colors.deepPurple,
        textColor: Colors.white,
        padding: const EdgeInsets.all(12.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('SignIn with Google ', style: TextStyle(fontSize: 18.0)),
          Image.asset(
            'assets/google.png',
            height: 30.0,
            fit: BoxFit.fill,
          ),
        ]),
        onPressed: () => {},
      ),
    ];
  }
}
