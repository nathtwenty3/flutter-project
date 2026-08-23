import 'package:flutter/material.dart';
import 'package:pro_23/screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

const Color primaryColor = Color(0xFF00AAA0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: primaryColor,
        ),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
