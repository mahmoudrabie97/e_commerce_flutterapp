import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signup(String email, String password) async {
    final _authresult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _authresult;
  }

  Future<UserCredential> signin(String email, String password) async {
    final _authresult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return _authresult;
  }
}
