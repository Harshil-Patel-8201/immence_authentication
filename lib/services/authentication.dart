import 'package:firebase_auth/firebase_auth.dart';
import 'package:immence_authentication/services/databse.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = _auth.currentUser;
      await DatabaseService(uid: user!.uid).upDateUserData(
        email,
        '',
      );

      return 'Signed Up';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Something Went Wrong.";
      }
    } catch (e) {
      print(e);
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
    print('signout');
  }
}
