import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final webClintId = '940824697310-dctq1cjbpqt100ht3vnmf6hquc6u72op.apps.googleusercontent.com';

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> registerWithEmail(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   final googleUser = await _googleSignIn.signIn();
  //   if (googleUser == null) {
  //     throw Exception('تم إلغاء تسجيل الدخول من قبل المستخدم');
  //   }
  //
  //   final googleAuth = await googleUser.authentication;
  //
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   return await _auth.signInWithCredential(credential);
  // }

  Future<void> signInWithGoogle() async{
    await _googleSignIn.initialize(
        clientId: webClintId
    );

    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.authenticate();

    if (googleSignInAccount.email == null) {
      throw Exception('تم إلغاء تسجيل الدخول من قبل المستخدم');
    }

    final GoogleSignInAuthentication googleSignInAuthentication = googleSignInAccount.authentication;

    final credintial = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
    );

    await _auth.signInWithCredential(credintial);
  }
}