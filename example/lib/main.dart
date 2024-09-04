// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wiseasy_sdk/wiseasy_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> logs = [];
  late WisePosPrinter printer;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await WisePosSdk.initialize();
    addLogs("Initialized Sdk");
    printer = WisePosSdk.printer;
  }

  void addLogs(log) {
    if (log is PlatformException) {
      logs.add(log.message?.toString() ?? log.toString());
    } else {
      logs.add(log.toString());
    }
    setState(() {});
  }

  Future<void> printSample() async {
    // Initializing the printer.
    await printer.initialize();

    // Set the printer gray value.
    await printer.setGrayLevel(2);

    // Gets the current status of the printer
    Map<String, dynamic> status = await printer.getPrinterStatus();
    print("Status: $status");

    // Gets whether the printer is out of paper from the map file.
    if (status["paper"] == 1) {
      throw Exception("Printer does not have paper");
    }

    // When printing text information, the program needs to set the printing font. The current setting is the default font.
    await printer.setPrintFont({'font': 'DEFAULT'});

    // Add Image from assets
    await printer.addAsset(asset: 'assets/discount_img.png');

    var textInfo = TextInfo(
      text: "www.test.com",
      align: PrinterAlign.center,
      fontSize: 32,
    );
    await printer.setLineSpacing(1);
    await printer.addSingleText(textInfo);

    textInfo = textInfo.copyWith(
      text: "--------------------------------------------",
      align: PrinterAlign.center,
    );
    await printer.addSingleText(textInfo);

    textInfo.align = PrinterAlign.left;
    textInfo.text = "Meal Package:KFC \$100 coupons";
    await printer.addSingleText(textInfo);

    textInfo.text = "Selling Price:\$90";
    await printer.addSingleText(textInfo);

    textInfo.text = "Merchant Name:KFC";
    await printer.addSingleText(textInfo);

    textInfo.text = "Payment Time:17/3/29 9:27";
    await printer.addSingleText(textInfo);

    textInfo.align = PrinterAlign.center;
    textInfo.text = "--------------------------------------------";
    await printer.addSingleText(textInfo);

    // Barcode Test
    await printer.addBarCode(barcode: "abcd");
    textInfo.text = "--------------------------------------------";
    await printer.addSingleText(textInfo);

    // QrCode
    await printer.addQrCode(qrCode: "abcd");
    textInfo.text = "--------------------------------------------";
    await printer.addSingleText(textInfo);

    textInfo.text = "Thanks For Using";
    await printer.addSingleText(textInfo);

    print("Starting print");
    await printer.startPrinting();
    await printer.feedPaper(30);
    print("Printing completed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wiseasy SDK'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    await printSample();
                  } catch (e) {
                    addLogs(e);
                  }
                },
                child: const Text("PrintSample"),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    addLogs(await WisePosSdk.printer.getPrinterStatus());
                  } catch (e) {
                    addLogs(e);
                  }
                },
                child: const Text("Printer Status"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    addLogs(await WisePosSdk.printer.getPrinterMileage());
                  } catch (e) {
                    addLogs(e);
                  }
                },
                child: const Text("GetPrinterMileage"),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await WisePosSdk.printer.clearPrinterMileage();
                  } catch (e) {
                    addLogs(e);
                  }
                },
                child: const Text("ClearPrinterMileage"),
              )
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  addLogs(await WisePosSdk.device.getVersionInfo());
                },
                child: const Text("DeviceVersion"),
              ),
              ElevatedButton(
                onPressed: () async {
                  addLogs(await WisePosSdk.device.getKernelVersion());
                },
                child: const Text("KernelVersion"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  addLogs(await WisePosSdk.device.getDeviceSn());
                },
                child: const Text("DeviceSn"),
              ),
              ElevatedButton(
                onPressed: () async {
                  addLogs(await WisePosSdk.device.getTamperStatus());
                },
                child: const Text("TamperStatus"),
              )
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(logs[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
