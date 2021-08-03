import 'package:flutter/material.dart';
import 'package:tolonglah/services/auth.dart';
import 'package:tolonglah/shared/constants.dart';
import 'package:tolonglah/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field stat
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Center(
            child: Scaffold(
              backgroundColor: Colors.amber[200],
              appBar: AppBar(
                backgroundColor: Colors.amber[400],
                elevation: 0.0,
                title: Text('Sign In to FFSB'),
                actions: <Widget>[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person_add),
                    label: Text('Register'),
                  ),
                ],
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Column(
                      children: <Widget>[
                        // ignore: prefer_const_constructors
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                          ),
                          validator: (val) => val!.length < 6
                              ? 'Enter password 6 character long'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Please supply a valid email and/or password';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            icon: Icon(Icons.person),
                            label: Text('Sign In')),
                        SizedBox(height: 12),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )
                      ],
                    )),
              ),
            ),
          );
  }
}
