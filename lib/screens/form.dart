import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';
import 'package:tolonglah/models/user.dart';
import 'package:tolonglah/services/auth.dart';
import 'package:tolonglah/services/database.dart';
import 'package:tolonglah/shared/loading.dart';
import 'package:tolonglah/shared/constants.dart';
import 'package:intl/intl.dart';
import 'package:quiver/iterables.dart';

class Borang extends StatefulWidget {
  @override
  State<Borang> createState() => _BorangState();
}

class _BorangState extends State<Borang> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String name = '';
  String cmrfile = '';
  String cmrNo = '';
  String complaint = '';
  String franchise = '';
  String stationName = '';
  String workOrderNo = '';
  String natureOfComplaint = '';
  List<PickedFile> _image = List.empty();
  late Reference ref;
  bool loading = false;
  var fileNames = [];
  var fileBytes = [];

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      final user = Provider.of<LocalUser?>(context);
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
        body: Container(
          child: Align(
            alignment: Alignment.center,
            child: ListView(children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'ECMR FORM',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Technician Name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an entry' : null,
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'CMR File'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          cmrfile = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Complaint'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          complaint = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Franchise'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          franchise = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Nature of Complaint'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          natureOfComplaint = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Station Name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          stationName = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Work Order No'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          workOrderNo = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'CMR NO'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          cmrNo = val;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                        onPressed: () {
                          selectFile();
                        },
                        icon: Icon(Icons.upload),
                        label: Text('Select Images')),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          await uploadToFirebase(user);
                          setState(() {
                            loading = false;
                          });
                        },
                        icon: Icon(Icons.upload),
                        label: Text('Upload Images')),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                        onPressed: () async {
                          dynamic result = DatabaseService(uid: 'xd')
                              .updateUserData(
                                  name,
                                  cmrfile,
                                  cmrNo,
                                  complaint,
                                  franchise,
                                  stationName,
                                  workOrderNo,
                                  natureOfComplaint);
                        },
                        icon: Icon(Icons.person),
                        label: Text('Upload Form')),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    }
  }

  Future selectFile() async {
    var result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    for (var imej in result.files) {
      var fileByte = imej.bytes;
      fileBytes.add(fileByte!);
      var fileName = imej.name;
      fileNames.add(fileName);
    }
  }

  Future? uploadToFirebase(var user) async {
    final dateTime = DateFormat("dd-MM-yyyy").format(DateTime.now());
    FirebaseStorage storange = FirebaseStorage.instance;
    for (var pair in zip([fileBytes, fileNames])) {
      await FirebaseStorage.instance
          .ref('ecmrforms/$user/$dateTime/${pair[1].toString()}')
          .putData(pair[0]);
    }
    print('is this even working');
  }
}
