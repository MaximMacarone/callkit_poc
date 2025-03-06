
import 'package:dbus/dbus.dart';

enum CallStatus {
  unknown,
  disconnected,
  dialing,    // outcoming call
  ringing,    // incoming call
  rejecting,
  accepting,
  active,
  held,
}

class Call extends DBusObject {

  static const call1InterfaceName = "ru.auroraos.Call.Call1";

  final bool incoming;
  final String localHandle;
  final String localName;
  final String remoteHandle;
  final String remoteName;
  final bool? holdable;
  final String? uri;
  CallStatus status;

  Call(
    this.incoming,
    this.localHandle,
    this.localName,
    this.remoteHandle,
    this.remoteName,
    this.holdable,
    this.uri,
    this.status,
    {
      DBusObjectPath path = const DBusObjectPath.unchecked('/')
    }) : super(path);
  
}