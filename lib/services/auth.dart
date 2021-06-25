import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahlhaly_event_planner/models/user.dart';


class AuthService {
  final String uid;
  AuthService({this.uid});

  final CollectionReference GustesCollection =
  FirebaseFirestore.instance.collection('Users');

  final FirebaseAuth auth = FirebaseAuth.instance;


  // auth change user stream
  Stream<AppUser> get user {
    return auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }


  // create user obj based on firebase user
  AppUser _userFromFirebaseUser(User user) {
    return user != null ? AppUser(uid: user.uid): null;
  }


  // Reset Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }








  // Updating User Data
  Future<void> updateUserData(
      String fName, String lName, String phone, String gender,String nid,String utype) async {
    return await GustesCollection.doc(uid).set({
      'FirstName': fName,
      'LastName': lName,
      'Phone': phone,
      'Gender': gender,
      'NationalID':nid,
      'UserType':utype
    });
  }



// sign out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}