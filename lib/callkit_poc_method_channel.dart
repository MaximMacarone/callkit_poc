import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'callkit_poc_platform_interface.dart';

/// An implementation of [CallkitPocPlatform] that uses method channels.
class MethodChannelCallkitPoc extends CallkitPocPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('callkit_poc');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
