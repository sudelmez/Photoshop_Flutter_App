import 'package:flutter/material.dart';
import 'package:photoshop_trial/product/home/homeview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Photoshop Trial App',
        home: HomeView());
  }
}
