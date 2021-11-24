import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttercompoundapp/core/models/user.dart';

import '../../locator.dart';
import 'firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  late AuthUser _currentUser;
  AuthUser get currentUser => _currentUser;

  Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _populateCurrentUser(userCredential.user);

      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = AuthUser(
        id: userCredential.user!.uid,
        email: email,
        fullName: fullName,
        userRole: role,
      );

      await _firestoreService.createUser(_currentUser);

      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    User? user = _firebaseAuth.currentUser;
    await _populateCurrentUser(user);

    return Future.value(user != null);
  }

  Future _populateCurrentUser(User? user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
}
