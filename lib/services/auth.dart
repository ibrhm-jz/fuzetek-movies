import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:fusetek_movies/data/models/user_model.dart';
import 'package:fusetek_movies/ui/widgets/defaultToast.dart';

class Auth {
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  User? userFirebase(auth.User? user) {
    if (user == null) return null;
    return User(uid: user.uid, email: user.email);
  }

  Stream<User?>? get user {
    return firebaseAuth.authStateChanges().map(userFirebase);
  }

  Future<User?> singIn(
    String email,
    String password,
  ) async {
    try {
      final credencial = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userFirebase(credencial.user);
    } on auth.FirebaseException catch (e) {
      showErrToast(e.message);
    }
  }

  Future<User?> createUser(
    String email,
    String password,
  ) async {
    final credencial = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userFirebase(credencial.user);
  }

  Future<void> logout() async {
    return await firebaseAuth.signOut();
  }
}
