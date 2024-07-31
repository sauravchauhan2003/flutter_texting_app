import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservices {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _firestore.collection('users').doc(userCredential.user?.uid).set(
          {"uid": userCredential.user?.uid, "email": email},
          SetOptions(merge: true));
      return userCredential;
    } catch (e) {
      throw (e);
    }
  }

  //sign up
  Future<UserCredential> signUpwithEmailpassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({"uid": userCredential.user?.uid, "email": email});
      return userCredential;
    } catch (e) {
      throw (e);
    }
  }

  Future<void> Signout() async {
    return await _auth.signOut();
  }

  //error handling
}
