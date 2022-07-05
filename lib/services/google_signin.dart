import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignup(BuildContext context) async {
    await Firebase.initializeApp();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAcc = await googleSignIn.signIn();
    if (googleSignInAcc != null) {
      final GoogleSignInAuthentication googleSignInAuth =
          await googleSignInAcc.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuth.idToken,
          accessToken: googleSignInAuth.accessToken);
      UserCredential result = await auth.signInWithCredential(credential);
      User? user = result.user;
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
        print(user.displayName);
      }
    }
  }

  Future<void> adminLogin() async {
    await Firebase.initializeApp();
    print('waiting');
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: 'f20210708@pilani.bits-pilani.ac.in', password: '1234567890');
    print(user);
  }

  Future signOut(context) async {
    await Firebase.initializeApp();
    await auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }
}
