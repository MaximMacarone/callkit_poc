import 'package:flutter_test/flutter_test.dart';
import 'package:callkit_poc/callkit_poc.dart';
import 'package:callkit_poc/callkit_poc_platform_interface.dart';
import 'package:callkit_poc/callkit_poc_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCallkitPocPlatform
    with MockPlatformInterfaceMixin
    implements CallkitPocPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CallkitPocPlatform initialPlatform = CallkitPocPlatform.instance;

  test('$MethodChannelCallkitPoc is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCallkitPoc>());
  });

  test('getPlatformVersion', () async {
    CallkitPoc callkitPocPlugin = CallkitPoc();
    MockCallkitPocPlatform fakePlatform = MockCallkitPocPlatform();
    CallkitPocPlatform.instance = fakePlatform;

    expect(await callkitPocPlugin.getPlatformVersion(), '42');
  });
}
