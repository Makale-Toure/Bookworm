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
    apiKey: 'AIzaSyDSYUszF9IRX3kaWIak5nsNgWeBT5lsny4',
    appId: '1:302264038190:web:7cac7f564d3b6f57c0c0bf',
    messagingSenderId: '302264038190',
    projectId: 'bookworm-2024',
    authDomain: 'bookworm-2024.firebaseapp.com',
    storageBucket: 'bookworm-2024.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZqI0pgH56jfponbego6U1uYLsEy7QNNg',
    appId: '1:302264038190:android:c8db91bb5247d966c0c0bf',
    messagingSenderId: '302264038190',
    projectId: 'bookworm-2024',
    storageBucket: 'bookworm-2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7iFdLpsn_lVlu0nUO-WiMDNT_wz-GimE',
    appId: '1:302264038190:ios:ccb2ce91c69f619ac0c0bf',
    messagingSenderId: '302264038190',
    projectId: 'bookworm-2024',
    storageBucket: 'bookworm-2024.appspot.com',
    iosBundleId: 'com.example.bookworm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7iFdLpsn_lVlu0nUO-WiMDNT_wz-GimE',
    appId: '1:302264038190:ios:ccb2ce91c69f619ac0c0bf',
    messagingSenderId: '302264038190',
    projectId: 'bookworm-2024',
    storageBucket: 'bookworm-2024.appspot.com',
    iosBundleId: 'com.example.bookworm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDSYUszF9IRX3kaWIak5nsNgWeBT5lsny4',
    appId: '1:302264038190:web:9758477266f33382c0c0bf',
    messagingSenderId: '302264038190',
    projectId: 'bookworm-2024',
    authDomain: 'bookworm-2024.firebaseapp.com',
    storageBucket: 'bookworm-2024.appspot.com',
  );
}