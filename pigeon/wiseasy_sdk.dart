import 'package:pigeon/pigeon.dart';

// dart run pigeon --input pigeon/wiseasy_sdk.dart
@ConfigurePigeon(
  PigeonOptions(
    dartPackageName: 'wiseasy_sdk',
    dartOut: 'lib/src/generated/wiseasy_sdk.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/visionpay/wiseasy_sdk/WiseasySdk.g.kt',
    kotlinOptions: KotlinOptions(package: 'com.visionpay.wiseasy_sdk'),
  ),
)

/// Flutter -> Native
@HostApi()
abstract class WiseasyPlatformChannel {
  int? initialize();

  void dispose();

  int? printSample();

  int? paperFeed(int distance);

  int? printLine(
    String text,
    int fontSize,
    PrinterAlign align,
    bool bold,
    bool italic,
  );

  int? stopPrint();
}

/// Native -> Flutter
// @FlutterApi()
// abstract class WiseasyCallbackChannel {
//   void onUpdate();
// }

enum PrinterAlign { left, center, right }
