import 'package:firebase_auth/firebase_auth.dart';
import 'package:tolonglah/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Function error;
  //create user object based on firebaseuser

  LocalUser? _userFromFirebase(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? LocalUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<LocalUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      return null;
    }
  }

  //sign in email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //registr with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
