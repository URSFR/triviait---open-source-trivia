import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {

  // FIREBASE
  @EnviedField(varName: 'apiKey', obfuscate: true)
  static final String apiKey = _Env.apiKey;
  @EnviedField(varName: 'authDomain', obfuscate: true)
  static final String authDomain = _Env.authDomain;
  @EnviedField(varName: 'storageBucket', obfuscate: true)
  static final String storageBucket = _Env.storageBucket;
  @EnviedField(varName: 'appId', obfuscate: true)
  static final String appId = _Env.appId;
  @EnviedField(varName: 'messagingSenderId', obfuscate: true)
  static final String messagingSenderId = _Env.messagingSenderId;
  @EnviedField(varName: 'projectId', obfuscate: true)
  static final String projectId = _Env.projectId;
  @EnviedField(varName: 'measurementId', obfuscate: true)
  static final String measurementId = _Env.measurementId;

}
