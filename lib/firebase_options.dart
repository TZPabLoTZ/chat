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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA1RL9vnMx9Yw3Twg-T1Pe6nAYDaaYftRU',
    appId: '1:591356009547:web:19c20893901cf6cc4cc1ce',
    messagingSenderId: '591356009547',
    projectId: 'chat-strawti',
    authDomain: 'chat-strawti.firebaseapp.com',
    storageBucket: 'chat-strawti.firebasestorage.app',
    measurementId: 'G-MFSEEZXWL8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1AIAQQzKPd3xIVehkprAYt8gHQffPR7Y',
    appId: '1:591356009547:android:019a3a3f1ff0640a4cc1ce',
    messagingSenderId: '591356009547',
    projectId: 'chat-strawti',
    storageBucket: 'chat-strawti.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaw7dA2KJP4kaHXJFZ4_YLvoLM9oKc5-Q',
    appId: '1:591356009547:ios:a42b13477212a6e24cc1ce',
    messagingSenderId: '591356009547',
    projectId: 'chat-strawti',
    storageBucket: 'chat-strawti.firebasestorage.app',
    iosClientId: '591356009547-l5ut4e4lfmi2fqkuui3iu9g7nm55j9uf.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );

}