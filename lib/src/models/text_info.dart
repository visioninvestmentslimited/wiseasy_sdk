import 'package:wiseasy_sdk/src/generated/wiseasy_sdk.g.dart';

class TextInfo {
  String text;
  PrinterAlign align;
  int fontSize;
  int width;
  int columnSpacing;
  bool isBold;
  bool isItalic;
  bool isWithUnderline;
  bool isReverseText;

  TextInfo({
    required this.text,
    this.align = PrinterAlign.left,
    this.fontSize = 24,
    this.width = -1,
    this.columnSpacing = -1,
    this.isBold = false,
    this.isItalic = false,
    this.isWithUnderline = false,
    this.isReverseText = false,
  });

  TextInfo copyWith({
    String? text,
    PrinterAlign? align,
    int? fontSize,
    int? width,
    int? columnSpacing,
    bool? isBold,
    bool? isItalic,
    bool? isWithUnderline,
    bool? isReverseText,
  }) {
    return TextInfo(
      text: text ?? this.text,
      align: align ?? this.align,
      fontSize: fontSize ?? this.fontSize,
      width: width ?? this.width,
      columnSpacing: columnSpacing ?? this.columnSpacing,
      isBold: isBold ?? this.isBold,
      isItalic: isItalic ?? this.isItalic,
      isWithUnderline: isWithUnderline ?? this.isWithUnderline,
      isReverseText: isReverseText ?? this.isReverseText,
    );
  }

  PrinterTextInfo toPrinterTextInfo() {
    return PrinterTextInfo(
      text: text,
      align: align,
      fontSize: fontSize,
      width: width,
      columnSpacing: columnSpacing,
      isBold: isBold,
      isItalic: isItalic,
      isWithUnderline: isWithUnderline,
      isReverseText: isReverseText,
    );
  }
}
