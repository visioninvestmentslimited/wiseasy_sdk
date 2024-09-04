import 'package:flutter/services.dart';
import 'package:wiseasy_sdk/src/generated/wiseasy_sdk.g.dart';
import 'package:wiseasy_sdk/src/models/text_info.dart';

class WisePosPrinter {
  WisePosPrinter._();
  static WisePosPrinter? _instance;
  static WisePosPrinter get instance => _instance ??= WisePosPrinter._();

  final WisePosPrinterChannel _channel = WisePosPrinterChannel();

  Future<void> initialize() => _channel.initialize();

  Future<void> printSample() => _channel.printSample();

  Future<void> addSingleText(TextInfo textInfo) =>
      _channel.addSingleText(textInfo.toPrinterTextInfo());

  Future<void> addMultiText(List<PrinterTextInfo> textInfoList) =>
      _channel.addMultiText(textInfoList);

  Future<void> addAsset({
    required String asset,
    PrinterAlign align = PrinterAlign.center,
  }) async {
    ByteData image = await rootBundle.load(asset);
    return addPicture(image: image.buffer.asUint8List(), align: align);
  }

  Future<void> addPicture({
    required Uint8List image,
    PrinterAlign align = PrinterAlign.center,
  }) {
    return _channel.addPicture(align, image);
  }

  Future<void> addBarCode({
    required String barcode,
    BarcodeType type = BarcodeType.barcode_128,
    int width = 100,
    int height = 100,
  }) {
    return _channel.addBarCode(type, width, height, barcode);
  }

  Future<void> addQrCode({
    required String qrCode,
    int width = 100,
    int height = 100,
  }) {
    return _channel.addQrCode(width, height, qrCode);
  }

  Future<void> setLineSpacing(int spacing) => _channel.setLineSpacing(spacing);

  Future<void> feedPaper(int dots) => _channel.feedPaper(dots);

  Future<void> startPrinting({Map<String, Object> options = const {}}) =>
      _channel.startPrinting(options);

  Future<Map<String, Object>> getPrinterStatus() async =>
      Map<String, Object>.from(await _channel.getPrinterStatus());

  Future<void> setGrayLevel(int level) => _channel.setGrayLevel(level);

  Future<void> setPrintFont(Map<String, Object> data) =>
      _channel.setPrintFont(data);

  Future<double> getPrinterMileage() => _channel.getPrinterMileage();

  Future<void> clearPrinterMileage() => _channel.clearPrinterMileage();
}
