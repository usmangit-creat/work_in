import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==========================================================
  //  1. SIGN UP FUNCTION (With Verification)
  // ==========================================================
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
    required String gender,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty && phone.isNotEmpty) {

        // A. Create User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // B. Add Data to Firestore
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'name': name,
          'email': email,
          'phone': phone,
          'role': role,
          'gender': gender,
          'createdAt': DateTime.now(),
        });

        // C. Send Verification Email
        await cred.user!.sendEmailVerification();

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        res = 'The email address is not valid.';
      } else {
        res = e.message ?? 'An unknown error occurred.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // ==========================================================
  //  2. LOGIN FUNCTION (Checks Verification)
  // ==========================================================
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // A. Try to Login
        UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // B. Check if Email is Verified
        if (!cred.user!.emailVerified) {
          await _auth.signOut();
          res = "Please verify your email first! Check your inbox.";
        } else {
          res = "success";
        }
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided.';
      } else if (e.code == 'invalid-credential') {
        res = 'Invalid email or password.';
      } else if (e.code == 'user-disabled') {
        res = 'This user has been banned.';
      } else {
        res = e.message ?? 'Login failed.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // ==========================================================
  //  3. RESET PASSWORD FUNCTION (Forgot Password)
  // ==========================================================
  Future<String> resetPassword({required String email}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty) {
        // Yeh line user ko Reset Email bhej degi
        await _auth.sendPasswordResetEmail(email: email);
        res = "success";
      } else {
        res = "Please enter your email first";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'invalid-email') {
        res = 'The email address is not valid.';
      } else {
        res = e.message ?? 'An unknown error occurred.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}