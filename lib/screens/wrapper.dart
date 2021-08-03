import 'package:flutter/material.dart';
import 'package:tolonglah/models/user.dart';
import 'package:tolonglah/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:tolonglah/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser?>(context);
    if (user?.uid == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
