import 'package:flutter/material.dart';
import 'package:tolonglah/services/auth.dart';
import 'package:tolonglah/shared/loading.dart';
import 'package:tolonglah/screens/form.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool loading = false;
  bool isSafetyUser = false;
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Loading();
    } else {
      return Scaffold(
        backgroundColor: Colors.amber[300],
        appBar: AppBar(
          title: Text('HOME'),
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
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                  child: Row(
                children: <Widget>[CircleAvatar()],
              )),
              ListTile(
                  title: const Text('ECMR FORM'),
                  onTap: () {
                    Navigator.pushNamed(context, '/form');
                  }),
              ListTile(
                  title: const Text('Safety'),
                  onTap: () {
                    Navigator.pushNamed(context, '/safety');
                  }),
            ],
          ),
        ),
      );
    }
  }
}
