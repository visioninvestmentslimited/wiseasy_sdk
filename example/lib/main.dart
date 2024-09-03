// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:wiseasy_sdk/wiseasy_sdk.dart';

void main() {
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
    int? result = await WiseasySdk.initialize();
    print("Initialize: $result");
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
                  int? result = await WiseasySdk.printSample();
                  print("Print Sample: $result");
                },
                child: const Text("Print Sample"),
              ),
              ElevatedButton(
                onPressed: () async {
                  int? result = await WiseasySdk.stopPrint();
                  print("Stop Print: $result");
                },
                child: const Text("Stop Print"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  int? result = await WiseasySdk.paperFeed(2);
                  print("Paper Feed: $result");
                },
                child: const Text("Paper Feed"),
              ),
              ElevatedButton(
                onPressed: () async {
                  int? result = await WiseasySdk.printLine(
                    text: "Test",
                    fontSize: 1,
                    align: PrinterAlign.center,
                    bold: true,
                    italic: true,
                  );
                  print("Print Line: $result");
                },
                child: const Text("Print Line"),
              )
            ],
          )
        ],
      ),
    );
  }
}
