import 'package:callkit_poc/call_manager.dart';
import 'package:callkit_poc/call_service_dom.dart';
import 'package:callkit_poc/org_freedesktop_dbus_objectmanager.dart';
import 'package:dbus/dbus.dart';

final class CallService {
  static const _dbusCallObjectPath = "/ru/auroraos/call_poc/DBus/Call1";
  static const _callManagerObjectPath = "/ru/auroraos/call_poc/DBus/ObjectManager";

  static const _callServiceName = "org.nemomobile.voicecall";
  static const _callServiceObjectPath = "/ru/auroraos/call/service";
  static const _callServiceInterfaceName = "ru.auroraos.Call.Service1";

  final DBusClient dbusSession = DBusClient.session();
  late final CallManager _callManager;
  late final CallServiceDom _objectManagerService;

  CallService() {
    _createCallManager();
    _createObjectManager();
  }

  void _createCallManager() {
    _callManager = CallManager(DBusObjectPath(_callManagerObjectPath));
  }

  void _createObjectManager() {
    _objectManagerService = CallServiceDom(dbusSession, _callServiceName, DBusObjectPath(_callServiceObjectPath));
  }



  void closeDBusSession() {
    dbusSession.close();
  }
}