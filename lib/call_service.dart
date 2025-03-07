import 'package:callkit_poc/call_manager.dart';
import 'package:callkit_poc/call_params.dart';
import 'package:callkit_poc/call_service_dom.dart';
import 'package:callkit_poc/org_freedesktop_dbus_object_manager.dart';
import 'package:dbus/dbus.dart';

final class CallService {
  static const _callManagerObjectPath = "/com/example/call_poc/DBus/ObjectManager";

  static const _callServiceName = "org.nemomobile.voicecall";
  static const _callServiceObjectPath = "/ru/auroraos/call/service";
  static const _callServiceInterfaceName = "ru.auroraos.Call.Service1";

  final DBusClient dbusSession = DBusClient.session();
  late final CallServiceDom _callServiceObjectManager;
  late final CallManager _callManager;
  late final OrgFreedesktopDBusObjectManager _objectManagerService;

  CallService() {
    _createCallManager();
    _registerAsCallManager();
  }

  void _createCallManager() {
    _callManager = CallManager(dbusSession, DBusObjectPath(_callManagerObjectPath));
  }

  void _registerAsCallManager() {
    _callServiceObjectManager = CallServiceDom(dbusSession, _callServiceName, DBusObjectPath(_callServiceObjectPath));
    _callServiceObjectManager.registerAsCallManager(_callServiceInterfaceName, DBusObjectPath(_callManagerObjectPath));
  }

  void startIncomingCall(CallParams params) {
    _callManager.startIncomingCall(params);
  }

  void closeDBusSession() {
    dbusSession.close();
  }
}