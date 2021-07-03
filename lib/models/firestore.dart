import 'package:cloud_firestore/cloud_firestore.dart';

class instaModel {
  String insta;

  //Contructor
  instaModel({
    required this.insta,

  });

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  adduser(instaModel instaModel) {
    _firestore.collection('Events').add({
      'instauser': instaModel.insta
    });
  }


  Stream<QuerySnapshot> loaduser() {
    return _firestore.collection('Users').snapshots();
  }


}
