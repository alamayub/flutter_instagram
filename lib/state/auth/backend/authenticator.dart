import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram/state/auth/constants/contants.dart';
import 'package:instagram/state/auth/models/auth_result.dart';
import 'package:instagram/state/posts/typedefs/user_id.dart';

class Authenticator {
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null; 
  String? get displayName => FirebaseAuth.instance.currentUser?.displayName;
  String? get email =>  FirebaseAuth.instance.currentUser?.email;

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
    } catch (e) {
      debugPrint('ERROR WHILE LOGOUT : ${e.toString()}');
    }
  }

  // login with email & password
  Future<AuthResult> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return AuthResult.success;
    } on FirebaseAuthException catch(e) {
      debugPrint('FACEBOOK ERROR WHILE FACEBOOK LOGIN : ${e.toString()}');
      return AuthResult.failure;
      // return linkWithCredentialAuth(exception: e, credential: credential);
    } catch (e) {
      debugPrint('FACEBOOK CATCH WHILE FACEBOOK LOGIN : ${e.toString()}');
      return AuthResult.failure; 
    }
  }

  // login with facebook account
  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.tokenString;
    if(token == null) {
      return AuthResult.aborted;
    }
    final credential = FacebookAuthProvider.credential(token);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthResult.success;
    } on FirebaseAuthException catch(e) {
      debugPrint('FACEBOOK ERROR WHILE FACEBOOK LOGIN : ${e.toString()}');
      return linkWithCredentialAuth(exception: e, credential: credential);
    } catch (e) {
      debugPrint('FACEBOOK CATCH WHILE FACEBOOK LOGIN : ${e.toString()}');
      return AuthResult.failure; 
    }
  }

  // login with google account
  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [Constants.googleCom]
    );
    final signInAccount = await googleSignIn.signIn();
    if(signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthResult.success;
    } on FirebaseAuthException catch(e) {
      debugPrint('GOOGLE ERROR WHILE FACEBOOK LOGIN : ${e.toString()}');
      return linkWithCredentialAuth(exception: e, credential: credential);
    } catch (e) {
      debugPrint('GOOGLE CATCH WHILE FACEBOOK LOGIN : ${e.toString()}');
      return AuthResult.failure; 
    }
  }

  // link credential 
  Future<AuthResult> linkWithCredentialAuth({
    required FirebaseAuthException exception,
    required OAuthCredential credential,
  }) async {
    final email = exception.email;
      final cred = exception.credential;
    if(exception.code == Constants.accountExistsWithDifferentCredential && email != null && cred != null) {
      final providers = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if(providers.contains(Constants.googleCom)) {
        await loginWithGoogle();
      } else if(providers.contains(Constants.facebookCom)) {
        await loginWithFacebook();
      }
      FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
      return AuthResult.success;
    }
    return AuthResult.failure;
  } 
 }