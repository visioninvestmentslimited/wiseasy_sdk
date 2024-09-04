import 'package:wiseasy_sdk/src/generated/wiseasy_sdk.g.dart';
import 'package:wiseasy_sdk/src/wisepos/wisepos_device.dart';
import 'package:wiseasy_sdk/src/wisepos/wisepos_printer.dart';

class WisePosSdk {
  static final WisePosChannel _channel = WisePosChannel();

  static Future<void> initialize() => _channel.initialize();

  static WisePosPrinter printer = WisePosPrinter.instance;

  static WisePosDevice device = WisePosDevice.instance;
}
