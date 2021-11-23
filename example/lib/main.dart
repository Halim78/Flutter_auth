import 'package:flutter/material.dart';
import 'package:flutter_microsoft_authentication_example/authenticate/authenticateInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Microsoft Authentication'),
        ),
        body: AuthenticateInfo(),
      ),
    );
  }
}
