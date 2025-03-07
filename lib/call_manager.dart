import 'dart:async';
import 'package:callkit_poc/call.dart';
import 'package:callkit_poc/call_params.dart';
import 'package:callkit_poc/org_freedesktop_dbus_object_manager.dart';
import 'package:dbus/dbus.dart';

class CallManager {
  static const _dbusCallObjectPath = "/com/example/call_poc/DBus/Call1";
  static const _call1InterfaceName = "ru.auroraos.Call.Call1";

  final DBusObjectPath objectPath;

  final DBusClient dbusSession;
  late final OrgFreedesktopDBusObjectManager callObjectManager;
  late final Call _managedCall;

  CallManager(
    this.dbusSession,
    this.objectPath,
  ) {
    _createObjectManager();
  }

  void _createObjectManager() async {
    callObjectManager = OrgFreedesktopDBusObjectManager(path: objectPath);
    await dbusSession.registerObject(callObjectManager);
  }

  void _registerCallObject() async {
    dbusSession.registerObject(_managedCall);
  }

  void startIncomingCall(CallParams params) {
    final _managedCall = Call(params, path: DBusObjectPath(_dbusCallObjectPath));
    _emitSignal();
  }

  void _emitSignal() async {
    _registerCallObject();
    final callData = {
      "Incoming": DBusBoolean(_managedCall.params.incoming),
      "Status": DBusInt16(_managedCall.params.status.index),
      "LocalHandle": DBusString(_managedCall.params.localHandle),
      "LocalName": DBusString(_managedCall.params.localName),
      "RemoteHandle": DBusString(_managedCall.params.remoteHandle),
      "RemoteName": DBusString(_managedCall.params.remoteName)
    };
    callObjectManager.addObjectToManagedObjects(_managedCall.path, {_call1InterfaceName: callData});
    await callObjectManager.emitInterfacesAdded(_managedCall.path, callObjectManager.getObjectProperties(_managedCall.path));
  }

}