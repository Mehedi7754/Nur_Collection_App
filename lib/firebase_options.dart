// File generated based on google-services.json

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA4CrDLhJTAV2lr6fsb9DoSrN7AoM7Dt6Q',
    appId: '1:924384853356:android:4d8545b9736091ebcd0749',
    messagingSenderId: '924384853356',
    projectId: 'ecommerce2-cffd1',
    authDomain: 'ecommerce2-cffd1.firebaseapp.com',
    storageBucket: 'ecommerce2-cffd1.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4CrDLhJTAV2lr6fsb9DoSrN7AoM7Dt6Q',
    appId: '1:924384853356:android:4d8545b9736091ebcd0749',
    messagingSenderId: '924384853356',
    projectId: 'ecommerce2-cffd1',
    storageBucket: 'ecommerce2-cffd1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4CrDLhJTAV2lr6fsb9DoSrN7AoM7Dt6Q',
    appId: '1:924384853356:ios:4d8545b9736091ebcd0749',
    messagingSenderId: '924384853356',
    projectId: 'ecommerce2-cffd1',
    storageBucket: 'ecommerce2-cffd1.firebasestorage.app',
    iosBundleId: 'com.example.eCommerce',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4CrDLhJTAV2lr6fsb9DoSrN7AoM7Dt6Q',
    appId: '1:924384853356:macos:4d8545b9736091ebcd0749',
    messagingSenderId: '924384853356',
    projectId: 'ecommerce2-cffd1',
    storageBucket: 'ecommerce2-cffd1.firebasestorage.app',
    iosBundleId: 'com.example.eCommerce',
  );
}
