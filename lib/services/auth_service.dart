import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Configure Google Sign In with proper scopes and serverClientId (web client ID)
  // The serverClientId is required to get ID token for Firebase authentication
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // Use the web client ID from google-services.json (client_type: 3)
    serverClientId:
        '924384853356-7kesb41e15nk2t8v8dmskpl5lqihclp7.apps.googleusercontent.com',
  );

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kDebugMode) {
        print('Google Sign In: Starting authentication flow');
      }

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        if (kDebugMode) {
          print('Google Sign In: User cancelled the sign-in');
        }
        return null;
      }

      if (kDebugMode) {
        print('Google Sign In: User selected - ${googleUser.email}');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (kDebugMode) {
        print(
          'Google Sign In: Got authentication - ID Token: ${googleAuth.idToken != null}',
        );
      }

      // Check if idToken is null
      if (googleAuth.idToken == null) {
        if (kDebugMode) {
          print('Google Sign In Error: ID Token is null');
          print('Access Token: ${googleAuth.accessToken != null}');
        }
        throw FirebaseAuthException(
          code: 'id-token-null',
          message:
              'ID Token is null. Please ensure SHA-1 fingerprint is added to Firebase Console.',
        );
      }

      if (kDebugMode) {
        print('Google Sign In: ID Token received successfully');
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      if (kDebugMode) {
        print('Google Sign In: Signing in with Firebase credential');
      }

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      if (kDebugMode) {
        print(
          'Google Sign In: Successfully signed in - ${userCredential.user?.email}',
        );
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Error: ${e.code} - ${e.message}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Google Sign In Error: $e');
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      if (kDebugMode) {
        print('Successfully signed out');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing out: $e');
      }
    }
  }
}
