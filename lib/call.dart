
import 'package:callkit_poc/call_params.dart';
import 'package:dbus/dbus.dart';

class Call extends DBusObject {

  final CallParams params;

  Call(
    this.params,
    {
      DBusObjectPath path = const DBusObjectPath.unchecked('/')
    }) : super(path);
  
  Future<DBusMethodResponse> getStatus() async {
    return DBusMethodSuccessResponse([DBusInt32(params.status.index)]);
  }


}