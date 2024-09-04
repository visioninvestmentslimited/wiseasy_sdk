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

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await WisePosSdk.initialize();
    addLogs("Initialized Sdk");
  }

  void addLogs(log) {
    if (log is PlatformException) {
      logs.add(log.message?.toString() ?? log.toString());
    } else {
      logs.add(log.toString());
    }
    setState(() {});
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
                    await WisePosSdk.printer.printSample();
                  } catch (e) {
                    addLogs(e);
                  }
                },
                child: const Text("Print Sample"),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    addLogs(await WisePosSdk.printer.getPrinterStatus());
                  } catch (e) {
                    addLogs(e);
                  }
                },
                child: const Text("GetPrinterStatus"),
              )
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
