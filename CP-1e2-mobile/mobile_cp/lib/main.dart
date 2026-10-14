import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Restaurante_Mesa_Cheia/pages/clientes_page.dart';

void main() {
  runApp(const ControleLotacaoApp());
}

class ControleLotacaoApp extends StatelessWidget {
  const ControleLotacaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante Mesa Cheia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B2D26),
          primary: const Color(0xFF7B2D26),
          secondary: const Color(0xFFD9A441),
          surface: const Color(0xFFFAF6F0),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF6F0),
        textTheme: GoogleFonts.latoTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF7B2D26),
          foregroundColor: Colors.white,
          titleTextStyle: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}