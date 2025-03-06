import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'callkit_poc_method_channel.dart';

abstract class CallkitPocPlatform extends PlatformInterface {
  /// Constructs a CallkitPocPlatform.
  CallkitPocPlatform() : super(token: _token);

  static final Object _token = Object();

  static CallkitPocPlatform _instance = MethodChannelCallkitPoc();

  /// The default instance of [CallkitPocPlatform] to use.
  ///
  /// Defaults to [MethodChannelCallkitPoc].
  static CallkitPocPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CallkitPocPlatform] when
  /// they register themselves.
  static set instance(CallkitPocPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
