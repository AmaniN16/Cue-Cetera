// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyDmiufeaFuN251GN14Q6BqnUJBGnaYtnVs',
    appId: '1:165523940817:web:9c8246486ba9837e0cecf0',
    messagingSenderId: '165523940817',
    projectId: 'cue-cetera-726df',
    authDomain: 'cue-cetera-726df.firebaseapp.com',
    databaseURL: 'https://cue-cetera-726df-default-rtdb.firebaseio.com',
    storageBucket: 'cue-cetera-726df.appspot.com',
    measurementId: 'G-22S7N882PJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8aNJlnUBGzQf2X_0ily890ZDNfqUqa5o',
    appId: '1:165523940817:android:a009fcd6f794570e0cecf0',
    messagingSenderId: '165523940817',
    projectId: 'cue-cetera-726df',
    databaseURL: 'https://cue-cetera-726df-default-rtdb.firebaseio.com',
    storageBucket: 'cue-cetera-726df.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCr2GwHVa9orzIMvD-jcM7v9fXmlPDMhT4',
    appId: '1:165523940817:ios:c6a7903e6ed1bf3b0cecf0',
    messagingSenderId: '165523940817',
    projectId: 'cue-cetera-726df',
    databaseURL: 'https://cue-cetera-726df-default-rtdb.firebaseio.com',
    storageBucket: 'cue-cetera-726df.appspot.com',
    iosClientId: '165523940817-69ont7jg8d21fmo5j6oq1hjr3854i8sr.apps.googleusercontent.com',
    iosBundleId: 'com.example.cueCetera',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCr2GwHVa9orzIMvD-jcM7v9fXmlPDMhT4',
    appId: '1:165523940817:ios:c6a7903e6ed1bf3b0cecf0',
    messagingSenderId: '165523940817',
    projectId: 'cue-cetera-726df',
    databaseURL: 'https://cue-cetera-726df-default-rtdb.firebaseio.com',
    storageBucket: 'cue-cetera-726df.appspot.com',
    iosClientId: '165523940817-69ont7jg8d21fmo5j6oq1hjr3854i8sr.apps.googleusercontent.com',
    iosBundleId: 'com.example.cueCetera',
  );
}
