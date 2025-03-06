// This file was generated using the following command and may be overwritten.
// dart-dbus generate-remote-object ./dbus_xml/org_freedesktop_DBus_ObjectManager.xml

import 'package:dbus/dbus.dart';

/// Signal data for org.freedesktop.DBus.ObjectManager.InterfacesAdded.
class OrgFreedesktopDBusObjectManagerInterfacesAdded extends DBusSignal {
  DBusObjectPath get object_path => values[0].asObjectPath();
  Map<String, Map<String, DBusValue>> get interfaces_and_properties => values[1].asDict().map((key, value) => MapEntry(key.asString(), value.asStringVariantDict()));

  OrgFreedesktopDBusObjectManagerInterfacesAdded(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

/// Signal data for org.freedesktop.DBus.ObjectManager.InterfacesRemoved.
class OrgFreedesktopDBusObjectManagerInterfacesRemoved extends DBusSignal {
  DBusObjectPath get object_path => values[0].asObjectPath();
  List<String> get interfaces => values[1].asStringArray().toList();

  OrgFreedesktopDBusObjectManagerInterfacesRemoved(DBusSignal signal) : super(sender: signal.sender, path: signal.path, interface: signal.interface, name: signal.name, values: signal.values);
}

class OrgFreedesktopDBusObjectManager extends DBusRemoteObject {
  /// Stream of org.freedesktop.DBus.ObjectManager.InterfacesAdded signals.
  late final Stream<OrgFreedesktopDBusObjectManagerInterfacesAdded> interfacesAdded;

  /// Stream of org.freedesktop.DBus.ObjectManager.InterfacesRemoved signals.
  late final Stream<OrgFreedesktopDBusObjectManagerInterfacesRemoved> interfacesRemoved;

  OrgFreedesktopDBusObjectManager(DBusClient client, String destination, DBusObjectPath path) : super(client, name: destination, path: path) {
    interfacesAdded = DBusRemoteObjectSignalStream(object: this, interface: 'org.freedesktop.DBus.ObjectManager', name: 'InterfacesAdded', signature: DBusSignature('oa{sa{sv}}')).asBroadcastStream().map((signal) => OrgFreedesktopDBusObjectManagerInterfacesAdded(signal));

    interfacesRemoved = DBusRemoteObjectSignalStream(object: this, interface: 'org.freedesktop.DBus.ObjectManager', name: 'InterfacesRemoved', signature: DBusSignature('oas')).asBroadcastStream().map((signal) => OrgFreedesktopDBusObjectManagerInterfacesRemoved(signal));
  }

  /// Invokes org.freedesktop.DBus.ObjectManager.GetManagedObjects()
  Future<Map<DBusObjectPath, Map<String, Map<String, DBusValue>>>> callGetManagedObjects({bool noAutoStart = false, bool allowInteractiveAuthorization = false}) async {
    var result = await callMethod('org.freedesktop.DBus.ObjectManager', 'GetManagedObjects', [], replySignature: DBusSignature('a{oa{sa{sv}}}'), noAutoStart: noAutoStart, allowInteractiveAuthorization: allowInteractiveAuthorization);
    return result.returnValues[0].asDict().map((key, value) => MapEntry(key.asObjectPath(), value.asDict().map((key, value) => MapEntry(key.asString(), value.asStringVariantDict()))));
  }
}
