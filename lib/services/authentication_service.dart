import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qr_mobile/services/database_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> googleignOut() async {
    await GoogleSignIn().signOut();
    print("Sign out");
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(
      {String email, String password, String name, String phoneNumber}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateProfile(displayName: name);
        await DatabaseService(name, email, user.uid, phoneNumber).addStaff();
      }
      return 'Signed up';
    } catch (e) {
      return e.message;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> registerUser(
      {String email, String password, String name, String phoneNumber}) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password);
      await app.delete();
      var user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateProfile(displayName: name);
        await DatabaseService(name, email, user.uid, phoneNumber).addStaff();
      }
      return Future.sync(() => userCredential);
    } on FirebaseAuthException catch (e) {}
  }
}
