
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcFIsKiYjLTejzQr6xzpi6dp71vr-POxk',
    appId: '1:782156832462:android:5ec2fc0378f3f6e9a0fa9f',
    messagingSenderId: '782156832462',
    projectId: 'autofarm-fb344',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLwsuoQWtOsyR2M1_9YXKz5qWSYbdq0Ec',
    appId: '1:782156832462:ios:6c121e438dd9880ea0fa9f',
    messagingSenderId: '782156832462',
    projectId: 'autofarm-fb344',
    iosBundleId: 'com.example.autofarm.autofarm',
  );


}
