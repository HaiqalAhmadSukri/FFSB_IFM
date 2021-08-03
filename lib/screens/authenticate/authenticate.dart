import 'package:flutter/material.dart';
import 'package:tolonglah/screens/authenticate/register.dart';
import 'package:tolonglah/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
    print(showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      return SignIn(
        toggleView: toggleView,
      );
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
