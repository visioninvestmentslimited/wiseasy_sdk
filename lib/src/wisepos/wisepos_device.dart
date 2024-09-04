import 'package:wiseasy_sdk/src/generated/wiseasy_sdk.g.dart';

class WisePosDevice {
  WisePosDevice._();
  static WisePosDevice? _instance;
  static WisePosDevice get instance => _instance ??= WisePosDevice._();

  final WisePosDeviceChannel _channel = WisePosDeviceChannel();

  Future<Map<String, String>> getVersionInfo() async =>
      Map<String, String>.from(await _channel.getVersionInfo());

  Future<Map<String, String>> getKernelVersion() async =>
      Map<String, String>.from(await _channel.getKernelVersion());

  Future<Map<String, int>> getTamperStatus() async =>
      Map<String, int>.from(await _channel.getTamperStatus());

  Future<String> getDeviceSn() => _channel.getDeviceSn();
}
