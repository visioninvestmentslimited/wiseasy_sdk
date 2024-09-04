// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
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
  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await WisePosSdk.initialize();
    print("Initialized");
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
                  await WisePosSdk.printer.printSample();
                },
                child: const Text("Print Sample"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await WisePosSdk.printer.startPrinting({});
                },
                child: const Text("Start Printing"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await WisePosSdk.printer.addSingleText(
                    PrinterTextInfo(
                      text: "Single Text",
                      align: 1,
                      fontSize: 24,
                      width: -1,
                      columnSpacing: -1,
                      isBold: false,
                      isItalic: false,
                      isWithUnderline: false,
                      isReverseText: false,
                    ),
                  );
                },
                child: const Text("Add Single Text"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await WisePosSdk.printer.initialize();
                  print("Initialize: ");
                },
                child: const Text("Initialize"),
              )
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  print(await WisePosSdk.device.getVersionInfo());
                },
                child: const Text("DeviceVersion"),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(await WisePosSdk.device.getKernelVersion());
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
                  print(await WisePosSdk.device.getDeviceSn());
                },
                child: const Text("DeviceSn"),
              ),
              ElevatedButton(
                onPressed: () async {
                  print(await WisePosSdk.device.getTamperStatus());
                },
                child: const Text("TamperStatus"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
