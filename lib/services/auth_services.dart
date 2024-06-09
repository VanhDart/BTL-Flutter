import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String name}) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        // for register user in auth with email and password
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //for addin user to our cloud firestore
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'uid': credential.user!.uid,
        });
        res = 'Successfulley';
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  // for login 
  Future<String> loginUser({required String email, required String password}) async{
    String res = "Some error Occurred";
    try {
       if (email.isNotEmpty || password.isNotEmpty){
        //login user with password , email
        await _auth.signInWithEmailAndPassword(
          email: email, 
          password: password
        );
        res = "Successfulley";
       }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<bool> logoutUse() async{
    try{
      await _auth.signOut();
      return true;
    } catch(e){
      print(e);
    }
    return false;
  }

 
}
