import 'package:flutter/material.dart';
import 'package:mood_book/screens/second_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> animation;
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: const Offset(0, 0),
    ).animate(animController);
    animController.forward();
    animController.addListener(() {
      if (animController.isCompleted) {
        animController.reverse();
      }
      if (animController.isDismissed) {
        animController.forward();
      }
    });
  }

  @override
  void dispose() {
    animController.dispose();

    super.dispose();
  }

  void onTap() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isOkeyed", true).then(
          (value) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SecondScreen(),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: animation,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 5),
                ),
                child: Text(
                  "MoodBook is an app that helps users track their mood daily with a simple interface. Users can also add brief descriptions of their day to provide context. The app then generates charts and graphs to show emotional patterns over time(Warning:Please do not delete app data)",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(80, 80),
                shape: const CircleBorder(
                  side: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              child: Text(
                "Ok",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
