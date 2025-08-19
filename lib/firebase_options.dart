import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) { throw UnsupportedError('DefaultFirebaseOptions have not been configured for web'); }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android: return android;
      case TargetPlatform.iOS: throw UnsupportedError('DefaultFirebaseOptions have not been configured for ios');
      default: throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4j4DFD7e5qJeRIpzhyRigX3l1E2n6je4',
    appId: '1:385918439846:android:9f3060e35aba5658a87f67',
    messagingSenderId: '385918439846',
    projectId: 'duelo-metabolico-app1',
    storageBucket: 'duelo-metabolico-app1.firebasestorage.app',
  );
}
