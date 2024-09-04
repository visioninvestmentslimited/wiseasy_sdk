import 'dart:typed_data';

import 'package:wiseasy_sdk/src/generated/wiseasy_sdk.g.dart';

class WisePosPrinter {
  WisePosPrinter._();
  static WisePosPrinter? _instance;
  static WisePosPrinter get instance => _instance ??= WisePosPrinter._();

  final WisePosPrinterChannel _channel = WisePosPrinterChannel();

  Future<void> initialize() => _channel.initialize();

  Future<void> printSample() => _channel.printSample();

  Future<void> addSingleText(PrinterTextInfo textInfo) =>
      _channel.addSingleText(textInfo);

  Future<void> addMultiText(List<PrinterTextInfo> textInfoList) =>
      _channel.addMultiText(textInfoList);

  Future<void> addPicture(PrinterAlign align, Uint8List image) =>
      _channel.addPicture(align, image);

  Future<void> addBarCode(
          BarcodeType type, int width, int height, String barcode) =>
      _channel.addBarCode(type, width, height, barcode);

  Future<void> addQrCode(int width, int height, String qrCode) =>
      _channel.addQrCode(width, height, qrCode);

  Future<void> setLineSpacing(int spacing) => _channel.setLineSpacing(spacing);

  Future<void> feedPaper(int dots) => _channel.feedPaper(dots);

  Future<void> startPrinting(Map<String, Object> options) =>
      _channel.startPrinting(options);

  Future<Map<String, Object>> getPrinterStatus() async =>
      Map<String, Object>.from(await _channel.getPrinterStatus());

  Future<int> setGrayLevel(int level) => _channel.setGrayLevel(level);

  Future<void> setPrintFont(Map<String, Object> data) =>
      _channel.setPrintFont(data);

  Future<double> getPrinterMileage() => _channel.getPrinterMileage();

  Future<void> clearPrinterMileage() => _channel.clearPrinterMileage();
}
