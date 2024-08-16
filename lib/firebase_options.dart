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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC_pn-ouNKRbiWvfCrC2GWAhTKZ5af_Vxo',
    appId: '1:951531659794:web:9c047a70dcb6e43028eecb',
    messagingSenderId: '951531659794',
    projectId: 'liveasy-f79db',
    authDomain: 'liveasy-f79db.firebaseapp.com',
    storageBucket: 'liveasy-f79db.appspot.com',
    measurementId: 'G-05TRX600ER',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVyPhgY2XSnsabhxK0z4hUyyikunIGWoY',
    appId: '1:951531659794:android:4516a2a6b4ed6cad28eecb',
    messagingSenderId: '951531659794',
    projectId: 'liveasy-f79db',
    storageBucket: 'liveasy-f79db.appspot.com',
  );
}
