// SPDX-FileCopyrightText: Copyright 2024 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause

import 'package:dbus/dbus.dart';

class OrgFreedesktopDBusObjectManager extends DBusObject {
  static const String objectManagerInterfaceName = 'org.freedesktop.DBus.ObjectManager';

  final Map<DBusObjectPath, Map<String, Map<String, DBusValue>>> _managedObjects =
      <DBusObjectPath, Map<String, Map<String, DBusValue>>>{};

  /// Creates a new object to expose on [path].
  OrgFreedesktopDBusObjectManager({DBusObjectPath path = const DBusObjectPath.unchecked('/')}) : super(path);

  void removeObjectFromManagedObjects(DBusObjectPath toRemove) {
    _managedObjects.remove(toRemove);
  }

  void addObjectToManagedObjects(DBusObjectPath objectPath, Map<String, Map<String, DBusValue>> properties) {
    _managedObjects[objectPath] = properties;
  }

  Map<String, Map<String, DBusValue>> getObjectProperties(DBusObjectPath objectPath) {
    return _managedObjects[objectPath]!;
  }

  /// Implementation of org.freedesktop.DBus.ObjectManager.GetManagedObjects()
  Future<DBusMethodResponse> doGetManagedObjects() async {
    Map<DBusValue, DBusValue> children = <DBusValue, DBusValue>{};
    for (MapEntry objData in _managedObjects.entries) {
      children[objData.key] = DBusDict(
          DBusSignature.string,
          DBusSignature.dict(
            DBusSignature.string,
            DBusSignature.variant,
          ),
          /// It always contains only one value
          _managedObjects.values.first.map((key, value) => MapEntry(
                DBusString(key),
                DBusDict.stringVariant(value),
              )));
    }
    return DBusMethodSuccessResponse([
      DBusDict(
          DBusSignature.objectPath,
          DBusSignature.dict(
            DBusSignature.string,
            DBusSignature.dict(
              DBusSignature.string,
              DBusSignature.variant,
            ),
          ),
          children)
    ]);
  }

  @override
  List<DBusIntrospectInterface> introspect() {
    return [
      DBusIntrospectInterface(objectManagerInterfaceName, methods: [
        DBusIntrospectMethod('GetManagedObjects', args: [
          DBusIntrospectArgument(
              DBusSignature.dict(
                  DBusSignature.objectPath,
                  DBusSignature.dict(
                      DBusSignature.string, DBusSignature.dict(DBusSignature.string, DBusSignature.variant))),
              DBusArgumentDirection.out,
              name: 'objpath_interfaces_and_properties')
        ])
      ], signals: [
        DBusIntrospectSignal('InterfacesAdded', args: [
          DBusIntrospectArgument(DBusSignature.objectPath, DBusArgumentDirection.in_, name: 'object_path'),
          DBusIntrospectArgument(
              DBusSignature.dict(DBusSignature.string, DBusSignature.dict(DBusSignature.string, DBusSignature.variant)),
              DBusArgumentDirection.in_,
              name: 'interfaces_and_properties')
        ]),
        DBusIntrospectSignal('InterfacesRemoved', args: [
          DBusIntrospectArgument(DBusSignature.objectPath, DBusArgumentDirection.in_, name: 'object_path'),
          DBusIntrospectArgument(DBusSignature.array(DBusSignature.string), DBusArgumentDirection.in_,
              name: 'interfaces')
        ])
      ])
    ];
  }

  @override
  Future<DBusMethodResponse> handleMethodCall(DBusMethodCall methodCall) async {
    if (methodCall.interface != objectManagerInterfaceName) {
      return DBusMethodErrorResponse.unknownInterface();
    }
    switch (methodCall.name) {
      case 'GetManagedObjects':
        return methodCall.values.isNotEmpty
            ? Future.value(DBusMethodErrorResponse.invalidArgs())
            : doGetManagedObjects();
      default:
        return DBusMethodErrorResponse.unknownMethod();
    }
  }

  @override
  Future<DBusMethodResponse> getProperty(String interface, String name) async {
    if (interface != objectManagerInterfaceName) {
      return DBusMethodErrorResponse.unknownInterface();
    }
    return DBusMethodErrorResponse.unknownProperty();
  }

  @override
  Future<DBusMethodResponse> setProperty(String interface, String name, DBusValue value) async {
    if (interface != objectManagerInterfaceName) {
      return DBusMethodErrorResponse.unknownInterface();
    }
    return DBusMethodErrorResponse.unknownProperty();
  }
}
