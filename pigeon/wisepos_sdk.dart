import 'package:pigeon/pigeon.dart';

// dart run pigeon --input pigeon/wisepos_sdk.dart
@ConfigurePigeon(
  PigeonOptions(
    dartPackageName: 'wiseasy_sdk',
    dartOut: 'lib/src/generated/wiseasy_sdk.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/visionpay/wiseasy_sdk/wisepos/WisePosSdk.g.kt',
    kotlinOptions: KotlinOptions(package: 'com.visionpay.wiseasy_sdk'),
  ),
)
@HostApi()
abstract class WisePosChannel {
  @async
  void initialize();
}

/// Printer Implementation
@HostApi()
abstract class WisePosPrinterChannel {
  void initialize();

  @async
  void startPrinting(Map<String, Object> options);

  void printSample();

  void addSingleText(PrinterTextInfo textInfo);

  void addMultiText(List<PrinterTextInfo> textInfoList);

  void addPicture(PrinterAlign align, Uint8List image);

  void addBarCode(BarcodeType type, int width, int height, String barcode);

  void addQrCode(int width, int height, String qrCode);

  void setLineSpacing(int spacing);

  void feedPaper(int dots);

  Map<String, Object> getPrinterStatus();

  int setGrayLevel(int level);

  void setPrintFont(Map<String, Object> data);

  double getPrinterMileage();

  void clearPrinterMileage();
}

/// Device Implementation
@HostApi()
abstract class WisePosDeviceChannel {
  Map<String, String> getVersionInfo();

  Map<String, String> getKernelVersion();

  Map<String, int> getTamperStatus();

  String getDeviceSn();
}

enum PrinterAlign { left, center, right }

enum BarcodeType {
  barcode_128,
  pdf_417,
  barcode_39,
}

class PrinterTextInfo {
  String text;
  int align;
  int fontSize;
  int width;
  int columnSpacing;
  bool isBold;
  bool isItalic;
  bool isWithUnderline;
  bool isReverseText;

  PrinterTextInfo({
    required this.text,
    this.align = 1,
    this.fontSize = 24,
    this.width = -1,
    this.columnSpacing = -1,
    this.isBold = false,
    this.isItalic = false,
    this.isWithUnderline = false,
    this.isReverseText = false,
  });
}
