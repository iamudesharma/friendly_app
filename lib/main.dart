import 'package:flutter/material.dart';

import 'package:appwrite/appwrite.dart';

Client client = Client();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('646ba3fd4cc07951b9c3')
      .setSelfSigned(status: true); //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(),
    );
  }
}
