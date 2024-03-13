import 'package:flutter/material.dart';
import 'package:mood_book/screens/mood_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() {
    return _ExampleState();
  }
}

class _ExampleState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MoodScreen(),
          ),
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/play_store_512.png",
              height: 150,
              width: 150,
            ),
            Text(
              "MoodBook",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Theme.of(context).colorScheme.background,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
