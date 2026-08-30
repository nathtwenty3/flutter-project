import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting Screen')),
      body: Center(
        child: Text(
          'Welcome to the Setting Screen!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
