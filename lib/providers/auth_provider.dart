import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  User? _user;
  UserModel? _userModel;
  bool _isLoading = false;

  User? get user => _user;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    // Wait a moment for Firebase to initialize before setting up listener
    Future.delayed(const Duration(milliseconds: 500), () {
      try {
        _authService.authStateChanges.listen((user) async {
          try {
            _user = user;
            if (user != null) {
              await loadUserData(user.uid);
            } else {
              _userModel = null;
            }
            notifyListeners();
          } catch (e) {
            if (kDebugMode) {
              print('Error in auth state listener: $e');
            }
            notifyListeners();
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print('Error setting up auth listener: $e');
        }
      }
    });
  }

  Future<void> loadUserData(String userId) async {
    _userModel = await _firestoreService.getUser(userId);
    notifyListeners();
  }

  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;
      notifyListeners();

      if (kDebugMode) {
        print('AuthProvider: Starting Google Sign In');
      }

      final userCredential = await _authService.signInWithGoogle();

      if (userCredential?.user == null) {
        if (kDebugMode) {
          print('AuthProvider: Sign in failed - user credential is null');
        }
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final user = userCredential!.user!;
      _user = user;

      if (kDebugMode) {
        print('AuthProvider: User signed in - ${user.email}, UID: ${user.uid}');
      }

      // Check if user exists in Firestore
      try {
        _userModel = await _firestoreService.getUser(user.uid);

        if (_userModel == null) {
          if (kDebugMode) {
            print(
              'AuthProvider: User not found in Firestore, creating new user document',
            );
          }
          // Create new user document
          final newUser = UserModel(
            id: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
          );
          await _firestoreService.createUser(newUser);
          _userModel = newUser;
          if (kDebugMode) {
            print('AuthProvider: User document created successfully');
          }
        } else {
          if (kDebugMode) {
            print('AuthProvider: User found in Firestore');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('AuthProvider: Error with Firestore operations: $e');
        }
        // Continue even if Firestore operations fail - user is still authenticated
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print(
          'AuthProvider: Firebase Auth Exception - ${e.code}: ${e.message}',
        );
      }
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print('AuthProvider: General Exception - $e');
      }
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _userModel = null;
    notifyListeners();
  }

  /// Sign in with email and password
  Future<String?> signInWithEmailPassword(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = credential.user;
      if (_user != null) {
        await loadUserData(_user!.uid);
      }

      _isLoading = false;
      notifyListeners();
      return null; // Success
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Wrong password provided.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-disabled':
          return 'This account has been disabled.';
        default:
          return e.message ?? 'An error occurred during sign in.';
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString();
    }
  }

  /// Register new user with email and password
  Future<String?> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Create user in Firebase Auth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = credential.user;
      
      if (_user != null) {
        // Update display name
        await _user!.updateDisplayName(name);
        
        // Create user document in Firestore
        final newUser = UserModel(
          id: _user!.uid,
          name: name,
          email: email,
        );
        
        await _firestoreService.createUser(newUser);
        _userModel = newUser;
      }

      _isLoading = false;
      notifyListeners();
      return null; // Success
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      
      switch (e.code) {
        case 'weak-password':
          return 'The password is too weak.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'invalid-email':
          return 'Invalid email address.';
        default:
          return e.message ?? 'An error occurred during registration.';
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString();
    }
  }

  Future<void> updateAddress(String address) async {
    if (_user != null) {
      await _firestoreService.updateUser(_user!.uid, {'address': address});
      if (_userModel != null) {
        _userModel = _userModel!.copyWith(address: address);
        notifyListeners();
      }
    }
  }
}
