import 'package:flutter/material.dart';
import 'package:mood_book/widgets/add_screen_first_widget.dart';

class AddMoods extends StatelessWidget {
  const AddMoods({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Add Today's Story",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
      body: const ScrollableMoodCards(),
    );
  }
}
