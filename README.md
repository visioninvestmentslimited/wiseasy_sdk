# Wiseasy Sdk

Flutter plugin to communicate with Wiseasy devices

## Getting Started

Download the current [Wiseasy SDK](https://wiseasygroup.feishu.cn/wiki/QACTwUFeLi09vTk059icNb5cn3g). Here you need the `WiseSdk_**.aar` files.

After you are all setup you need to add the SDKs `\*.aar`` file to your Android Project as Module.

1. Open the android folder of your flutter project
2. In the android root folder create a single folder for `WiseSdk`, place the corresponding aar file and create an empty `build.gradle` file
3. Content of the `WiseSdk/build.gradle` file:

```groovy
configurations.maybeCreate("default")
artifacts.add("default", file('WiseSdk_D_XXXX.aar'))
artifacts.add("default", file('WiseSdk_P_XXXX.aar'))
```

4. In the android root folder find `settings.gradle` file, open it and add the following line at the top of the file:

```groovy
include ":app"
include ':WiseSdk' // Add this
```

## Usage

#### Initialize Sdk first

```dart
await WisePosSdk.initialize();
```

#### Printer

```dart
WisePosPrinter printer = WisePosSdk.printer;

// Initializing the printer
await printer.initialize();

// Set the printer gray value
await printer.setGrayLevel(2);

Map<String, dynamic> status = await printer.getPrinterStatus();
// Gets whether the printer is out of paper from the map file.
if (status["paper"] == 1) {
  throw Exception("Printer does not have paper");
}

// When printing text information, the program needs to set the printing font. The current setting is the default font.
await printer.setPrintFont({'font': 'DEFAULT'});


// Add Text
var textInfo = TextInfo(text: "www.test.com", align: PrinterAlign.center, fontSize: 32);
await printer.setLineSpacing(1);
await printer.addSingleText(textInfo);

textInfo.align = PrinterAlign.left;
textInfo.text = "Sample Text";
await printer.addSingleText(textInfo);

// Add Image from assets
await printer.addAsset(asset: 'assets/discount_img.png');

// Add Barcode
await printer.addBarCode(barcode: "barcode");
textInfo.text = "--------------------------------------------";
await printer.addSingleText(textInfo);

// Add QrCode
await printer.addQrCode(qrCode: "qr_data");
textInfo.text = "--------------------------------------------";
await printer.addSingleText(textInfo);

// Print Data
await printer.startPrinting();
await printer.feedPaper(30);
```

#### Get device info

```dart
WisePosDevice device = WisePosSdk.device;

await device.getVersionInfo();

await device.getKernelVersion();

// ...other device methods
```
