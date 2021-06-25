import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:likee_app/models/user.dart';



class AuthService {
  final String uid;
  AuthService({required this.uid});

  final CollectionReference UsersCollection =
  FirebaseFirestore.instance.collection('Users');

  final FirebaseAuth auth = FirebaseAuth.instance;






  // create user obj based on firebase user
  AppUser? _userFromFirebaseUser(User user) {
    if (user != null) {
      return AppUser(uid: user.uid);
    } else {
      return null;
    }
  }


  // Reset Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }








  // Updating User Data
  Future<void> updateUserData(
      String insta, String email) async {
    return await UsersCollection.doc(uid).set({
      'instauser': insta,
      'email': email,

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