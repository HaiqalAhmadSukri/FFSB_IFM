// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tolonglah/models/user.dart';
import 'package:tolonglah/screens/form.dart';
import 'package:tolonglah/screens/safety.dart';
import 'package:tolonglah/screens/wrapper.dart';
import 'package:tolonglah/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LocalUser?>.value(
      catchError: (User, MyUser) => null,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        routes: {
          '/form': (context) => Borang(),
          '/safety': (context) => SafetyForm()
        },
        home: Wrapper(),
      ),
    );
  }
}
