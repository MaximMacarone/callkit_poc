import 'dart:async';
import 'package:callkit_poc/call.dart';
import 'package:callkit_poc/org_freedesktop_dbus_objectmanager.dart';
import 'package:dbus/dbus.dart';

class CallManager {

  final DBusObjectPath objectPath;

  final DBusClient dbusSession;
  late final OrgFreedesktopDBusObjectManager callObjectManager;


  void _createObjectManager() async {
    callObjectManager = OrgFreedesktopDBusObjectManager(dbusSession, )
    await dbusSession.registerObject(callObjectManager);
  }


}