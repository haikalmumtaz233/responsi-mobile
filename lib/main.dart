// NIM : 123210062
// Nama : Muhammad Raditya Haikal Mumtaz

import 'package:flutter/material.dart';
import 'package:responsi_tpm/db/local.dart';
import 'package:responsi_tpm/views/home_page.dart';
import 'package:responsi_tpm/views/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveToLocalDb.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valorant App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
