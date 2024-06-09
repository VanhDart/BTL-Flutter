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
    apiKey: 'AIzaSyBoJueOsrevGieba9FzyaeCxQHps5haC1o',
    appId: '1:500822419146:web:803e01a3a82fcdef47b633',
    messagingSenderId: '500822419146',
    projectId: 'flutter-288',
    authDomain: 'flutter-288.firebaseapp.com',
    storageBucket: 'flutter-288.appspot.com',
    measurementId: 'G-N45HJV9BZK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMbzx-KUYnz54-UKsSnX-kh1GG8UT_-Sw',
    appId: '1:500822419146:android:bc630d9fc274431b47b633',
    messagingSenderId: '500822419146',
    projectId: 'flutter-288',
    storageBucket: 'flutter-288.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7gUBX1Xg-T-ojGGKNd4dom4G2Slf4zCo',
    appId: '1:500822419146:ios:5c768ce63ab0b71147b633',
    messagingSenderId: '500822419146',
    projectId: 'flutter-288',
    storageBucket: 'flutter-288.appspot.com',
    iosBundleId: 'com.example.flutterApplication5',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7gUBX1Xg-T-ojGGKNd4dom4G2Slf4zCo',
    appId: '1:500822419146:ios:5c768ce63ab0b71147b633',
    messagingSenderId: '500822419146',
    projectId: 'flutter-288',
    storageBucket: 'flutter-288.appspot.com',
    iosBundleId: 'com.example.flutterApplication5',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBoJueOsrevGieba9FzyaeCxQHps5haC1o',
    appId: '1:500822419146:web:d6917637bdc12ae147b633',
    messagingSenderId: '500822419146',
    projectId: 'flutter-288',
    authDomain: 'flutter-288.firebaseapp.com',
    storageBucket: 'flutter-288.appspot.com',
    measurementId: 'G-9XN9VK9QE9',
  );
}