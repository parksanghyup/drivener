// lib/auth/firebase_auth_manager.dart
import 'package:firebase_auth/firebase_auth.dart';
import '../base_auth_user_provider.dart';
import '../auth_manager.dart';

class FirebaseAuthUser extends BaseAuthUser {
  final User user;

  FirebaseAuthUser(this.user);

  @override
  bool get loggedIn => user.uid.isNotEmpty;
  @override
  bool get emailVerified => user.emailVerified;

  @override
  AuthUserInfo get authUserInfo => AuthUserInfo(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        phoneNumber: user.phoneNumber,
      );

  @override
  Future delete() => user.delete();
  @override
  Future updateEmail(String email) => user.updateEmail(email);
  @override
  Future updatePassword(String password) => user.updatePassword(password);
  @override
  Future sendEmailVerification() => user.sendEmailVerification();
  @override
  Future refreshUser() => user.reload();
}

class FirebaseAuthManager
    with
        AuthManager,
        EmailSignInManager {
  final _auth = FirebaseAuth.instance;

  @override
  Future signOut() async => _auth.signOut();

  @override
  Future deleteUser(BuildContext context) async {
    await currentUser?.delete();
  }

  @override
  Future updateEmail({required String email, required BuildContext context}) async {
    await currentUser?.updateEmail(email);
  }

  @override
  Future resetPassword({required String email, required BuildContext context}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<BaseAuthUser?> signInWithEmail(BuildContext context, String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    currentUser = FirebaseAuthUser(result.user);
    return currentUser;
  }

  @override
  Future<BaseAuthUser?> createAccountWithEmail(BuildContext context, String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    currentUser = FirebaseAuthUser(result.user);
    return currentUser;
  }
}
