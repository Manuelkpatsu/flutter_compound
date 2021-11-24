import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttercompoundapp/core/models/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
  FirebaseFirestore.instance.collection("users");

  Future createUser(AuthUser user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      DocumentSnapshot userData = await _usersCollectionReference.doc(uid).get();
      return AuthUser.fromData(userData.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
