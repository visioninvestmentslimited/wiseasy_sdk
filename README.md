# Wiseasy Sdk

![wiseasy](https://github.com/user-attachments/assets/09ec3e85-7aa8-46c5-a9b5-4d483892d056)

Unofficial Flutter plugin to communicate with Wiseasy devices

## Getting Started

1. **Download the Wiseasy SDK:**

   - Access the latest Wiseasy SDK from the [Wiseasy SDK Download Page](https://wiseasygroup.feishu.cn/wiki/QACTwUFeLi09vTk059icNb5cn3g).
   - Download the `WiseSdk_**.aar` files that are required for your project.

2. **Organize the SDK in Your Project:**

   - Navigate to the `android` directory of your Flutter project.
   - Create a new folder named `WiseSdk` within the `android` directory.
   - Place the downloaded `.aar` files (e.g., `WiseSdk_D_XXXX.aar`, `WiseSdk_P_XXXX.aar`) into the `WiseSdk` folder.

3. **Create a `build.gradle` File for the SDK:**

   - Inside the `WiseSdk` folder, create a new `build.gradle` file with the following content:

   ```groovy
   configurations.maybeCreate("default")
   artifacts.add("default", file('WiseSdk_D_XXXX.aar'))
   artifacts.add("default", file('WiseSdk_P_XXXX.aar'))
   ```

   Note: Replace WiseSdk_D_XXXX.aar and WiseSdk_P_XXXX.aar with the actual filenames of the .aar files you downloaded.

4. **Update settings.gradle to Include the SDK:**

   - In the android directory, locate the settings.gradle file.
   - Open it and add the following line to include the WiseSdk module:

   ```groovy
   include ":app"
   include ':WiseSdk'
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
