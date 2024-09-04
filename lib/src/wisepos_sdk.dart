import 'package:wiseasy_sdk/src/generated/wiseasy_sdk.g.dart';
import 'package:wiseasy_sdk/src/wisepos/wisepos_device.dart';
import 'package:wiseasy_sdk/src/wisepos/wisepos_printer.dart';

export 'package:wiseasy_sdk/src/wisepos/wisepos_device.dart';
export 'package:wiseasy_sdk/src/wisepos/wisepos_printer.dart';

class WisePosSdk {
  static final WisePosChannel _channel = WisePosChannel();
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    await _channel.initialize();
    _isInitialized = true;
  }

  static WisePosPrinter get printer {
    _ensureInitialized();
    return WisePosPrinter.instance;
  }

  static WisePosDevice get device {
    _ensureInitialized();
    return WisePosDevice.instance;
  }

  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw "WisePos SDK is not initialized";
    }
  }
}
