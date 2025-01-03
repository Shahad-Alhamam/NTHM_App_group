// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBUTjBeHgsBR1IFUWbz7fvcREJ8B-pIykk',
    appId: '1:443731028123:web:fead145e10a3f04672be3e',
    messagingSenderId: '443731028123',
    projectId: 'nthm-28a46',
    authDomain: 'nthm-28a46.firebaseapp.com',
    storageBucket: 'nthm-28a46.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSO3Ai9O5P4h7-gWuTPpNfej2soSqYPGs',
    appId: '1:443731028123:android:e8bedb7793b7799d72be3e',
    messagingSenderId: '443731028123',
    projectId: 'nthm-28a46',
    storageBucket: 'nthm-28a46.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4MMDrNbz9PenvBB6bzdfuOcm_t2rPvB0',
    appId: '1:443731028123:ios:a2ab08fd13f551e472be3e',
    messagingSenderId: '443731028123',
    projectId: 'nthm-28a46',
    storageBucket: 'nthm-28a46.appspot.com',
    iosBundleId: 'com.example.nthmApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4MMDrNbz9PenvBB6bzdfuOcm_t2rPvB0',
    appId: '1:443731028123:ios:a2ab08fd13f551e472be3e',
    messagingSenderId: '443731028123',
    projectId: 'nthm-28a46',
    storageBucket: 'nthm-28a46.appspot.com',
    iosBundleId: 'com.example.nthmApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBUTjBeHgsBR1IFUWbz7fvcREJ8B-pIykk',
    appId: '1:443731028123:web:ff82787427cb138872be3e',
    messagingSenderId: '443731028123',
    projectId: 'nthm-28a46',
    authDomain: 'nthm-28a46.firebaseapp.com',
    storageBucket: 'nthm-28a46.appspot.com',
  );
}
