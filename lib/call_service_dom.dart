import 'package:callkit_poc/call_manager.dart';
import 'package:callkit_poc/call_service.dart';
import 'package:dbus/dbus.dart';


final class CallServiceDom extends DBusRemoteObjectManager {

  CallServiceDom(
    DBusClient client,
    String callServiceName,
    DBusObjectPath callServiceObjectPath
  ) : super(client, name: callServiceName, path: callServiceObjectPath);
  
  Future<void> registerAsCallManager(
    String callServiceInterfaceName,
    DBusObjectPath callManagerObjectPath,
  ) async {
    await callMethod(
    callServiceInterfaceName,
    "RegisterCallManager",
    [callManagerObjectPath],
    );
  }
}