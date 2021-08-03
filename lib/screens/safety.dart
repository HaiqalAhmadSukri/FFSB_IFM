import 'package:flutter/material.dart';
import 'package:tolonglah/services/auth.dart';
import 'package:tolonglah/shared/loading.dart';

class SafetyForm extends StatefulWidget {
  const SafetyForm({Key? key}) : super(key: key);

  @override
  State<SafetyForm> createState() => _SafetyFormState();
}

class _SafetyFormState extends State<SafetyForm> {
  bool loading = false;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    if (loading)
      return Loading();
    else {
      return Scaffold(
          backgroundColor: Colors.amber[300],
          appBar: AppBar(
            title: Text('SAFETY'),
            centerTitle: true,
            backgroundColor: Colors.amber[200],
            actions: <Widget>[
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    await _auth.signOut();
                    setState(() {
                      loading = false;
                    });
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign Out'))
            ],
          ));
    }
  }
}
