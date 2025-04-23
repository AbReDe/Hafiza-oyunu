import 'package:flutter/material.dart';
import 'GirisEkrani.dart';







void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hafıza Oyun',
      theme: ThemeData(
        primarySwatch: Colors.orange, // Genel tema rengi olarak turuncuyu seçiyoruz
        fontFamily: 'Roboto', // Daha modern bir font
      ),
      home: const GirisEkrani(),
    );
  }
}




