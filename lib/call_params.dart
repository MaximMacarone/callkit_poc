
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

final class CallParams {
  final bool incoming;
  final String localHandle;
  final String localName;
  final String remoteHandle;
  final String remoteName;
  final bool? holdable;
  final String? uri;
  CallStatus status;

  CallParams(
    this.incoming,
    this.localHandle,
    this.localName,
    this.remoteHandle,
    this.remoteName,
    this.holdable,
    this.uri,
    this.status);
}