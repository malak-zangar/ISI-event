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
    apiKey: 'AIzaSyBeDLO8nyCuSNceYfp1gE2pipJEWLaY7nc',
    appId: '1:504895233759:web:dffc7be8bcd0c2a6e5536a',
    messagingSenderId: '504895233759',
    projectId: 'malak-project-isi',
    authDomain: 'malak-project-isi.firebaseapp.com',
    storageBucket: 'malak-project-isi.appspot.com',
    measurementId: 'G-F05TXZHVYY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6FqSRSjwpTURlgFOfhrtswS1a9vrNKBw',
    appId: '1:504895233759:android:0bad9415a3812defe5536a',
    messagingSenderId: '504895233759',
    projectId: 'malak-project-isi',
    storageBucket: 'malak-project-isi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCl5PEQDhmchzaduA1mWpeKo0amQEyklDM',
    appId: '1:504895233759:ios:bd5d4057d06c6d39e5536a',
    messagingSenderId: '504895233759',
    projectId: 'malak-project-isi',
    storageBucket: 'malak-project-isi.appspot.com',
    iosBundleId: 'com.example.flutterApplication2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCl5PEQDhmchzaduA1mWpeKo0amQEyklDM',
    appId: '1:504895233759:ios:bd5d4057d06c6d39e5536a',
    messagingSenderId: '504895233759',
    projectId: 'malak-project-isi',
    storageBucket: 'malak-project-isi.appspot.com',
    iosBundleId: 'com.example.flutterApplication2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBeDLO8nyCuSNceYfp1gE2pipJEWLaY7nc',
    appId: '1:504895233759:web:5f5254059546dbdbe5536a',
    messagingSenderId: '504895233759',
    projectId: 'malak-project-isi',
    authDomain: 'malak-project-isi.firebaseapp.com',
    storageBucket: 'malak-project-isi.appspot.com',
    measurementId: 'G-MPGHS5BCN9',
  );
}
