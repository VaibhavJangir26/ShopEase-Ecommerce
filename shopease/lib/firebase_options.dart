import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyDXROY8WTS_ix9oEVkxnCWQ2k21ARFkUTA",
      authDomain: "todo-app-401f8.firebaseapp.com",
      projectId: "todo-app-401f8",
      storageBucket: "todo-app-401f8.firebasestorage.app",
      messagingSenderId: "849937788806",
      appId: "1:849937788806:web:bb06401008fff9ec068607",
      measurementId: "G-217FPS5J8P"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBk81f4PXWPPoFqtE6irDYsyHrjMCyM1QQ',
    appId: '1:849937788806:android:7c5dcbf682c36cba068607',
    messagingSenderId: '849937788806',
    projectId: 'todo-app-401f8',
    storageBucket: 'todo-app-401f8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_IOS_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_IOS_STORAGE_BUCKET',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_MACOS_API_KEY',
    appId: 'YOUR_MACOS_APP_ID',
    messagingSenderId: 'YOUR_MACOS_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_MACOS_STORAGE_BUCKET',
    iosClientId: 'YOUR_MACOS_CLIENT_ID',
    iosBundleId: 'YOUR_MACOS_BUNDLE_ID',
  );
}
