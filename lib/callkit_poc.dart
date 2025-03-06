
import 'callkit_poc_platform_interface.dart';

class CallkitPoc {
  Future<String?> getPlatformVersion() {
    return CallkitPocPlatform.instance.getPlatformVersion();
  }
}
