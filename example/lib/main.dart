import 'package:azure_speech_recognition_services_example/screens/continuous_recognition_screen.dart';
import 'package:azure_speech_recognition_services_example/screens/home_screen.dart';
import 'package:azure_speech_recognition_services_example/screens/simple_recognition_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/azure.env');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void onLayoutDone(Duration timeStamp) async {
    debugPrint("Asking for microphone permission");
    final permissionStatus = await Permission.microphone.request();
    if (!permissionStatus.isGranted) {
      debugPrint("Microphone permission not granted");
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(onLayoutDone);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomeScreen(),
        '/simple': (context) => SimpleRecognitionScreen(),
        '/continuous': (context) => ContinuousRecognitionScreen(),
      },
    );
  }
}
