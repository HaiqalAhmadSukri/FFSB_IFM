import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //collection reference

  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection('ecmrforms');

  Future updateUserData(
      String name,
      String cmrfile,
      String cmrNo,
      String complaint,
      String franchise,
      String stationName,
      String workOrderNo,
      String natureOfComplaint) async {
    Map<String, String> data = {
      'cmrfile': cmrfile,
      'cmrno': cmrNo,
      'complaint': complaint,
      'franchise': franchise,
      'naturecomplaint': natureOfComplaint,
      'stationname': stationName,
      'technician': name,
      'workorderno': workOrderNo
    };
    return await usercollection.doc(uid).set(data);
  }
}
