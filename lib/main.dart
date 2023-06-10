import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'board.dart';


void main() => runApp(
  DevicePreview(
    builder: (context) => MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanban Board',
      home: TabbedApp(),
    );
  }
}



