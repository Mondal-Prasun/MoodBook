import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mood_book/screens/mood_screen.dart';
import 'package:mood_book/test.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.brown,
            background: const Color.fromARGB(158, 255, 153, 0),
            onPrimaryContainer: Colors.red,
          ),
          textTheme: TextTheme(
            titleLarge: GoogleFonts.acme(),
          ),
        ),
        home: const MoodScreen(),
      ),
    );
  }
}
