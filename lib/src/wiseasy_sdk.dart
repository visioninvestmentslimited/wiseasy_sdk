import 'package:wiseasy_sdk/src/generated/wiseasy_sdk.g.dart';

class WiseasySdk {
  static final WiseasyPlatformChannel _channel = WiseasyPlatformChannel();

  static Future<int?> initialize() => _channel.initialize();

  static Future<void> dispose() => _channel.dispose();

  static Future<int?> printSample() => _channel.printSample();

  static Future<int?> paperFeed(int distance) => _channel.paperFeed(distance);

  static Future<int?> printLine({
    required String text,
    required int fontSize,
    required PrinterAlign align,
    required bool bold,
    required bool italic,
  }) {
    return _channel.printLine(text, fontSize, align, bold, italic);
  }

  static Future<int?> stopPrint() => _channel.stopPrint();
}
