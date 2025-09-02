import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuFnvjVbi0SRBxbq6XwfuSwgO5WIYVlHg',
    appId: '1:663414934306:android:638a04260231b8d8a1337b',
    messagingSenderId: '663414934306',
    projectId: 'compact-haiku-424413-j3',
    storageBucket: 'compact-haiku-424413-j3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoaBtz9d05vuDif2dHJ0GMoGqXV0C7UTM',
    appId: '1:663414934306:ios:dev_app_id_here',
    messagingSenderId: '663414934306',
    projectId: 'compact-haiku-424413-j3',
    storageBucket: 'compact-haiku-424413-j3.firebasestorage.app',
    iosBundleId: 'com.example.dropMe.dev',
  );
}