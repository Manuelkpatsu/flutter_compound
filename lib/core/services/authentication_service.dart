import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      return user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      return user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    User? user = _firebaseAuth.currentUser;
    return Future.value(user != null);
  }
}
