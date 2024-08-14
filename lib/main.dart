import 'package:flutter/material.dart';
import 'package:contact/contact.dart';
import 'package:contact/info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Contact(),
      initialRoute: '/contact',
      routes: {
        '/contact': (context) => const Contact(),
        '/info': (context) => const Info(
          imageUrl: '',
          name: '',
          number: '',
        ),
      },
    );
  }
}
