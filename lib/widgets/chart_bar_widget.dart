import 'package:flutter/material.dart';
import 'package:mood_book/model/mood_model.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.moodVarient});
  final MoodVarient moodVarient;

  @override
  Widget build(BuildContext context) {
    double fill = switch (moodVarient) {
      MoodVarient.happy => 70,
      MoodVarient.sad => 10,
      MoodVarient.angry => 40,
      MoodVarient.surprise => 60,
      MoodVarient.fear => 30,
      MoodVarient.disgust => 20,
    };

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: FractionallySizedBox(
          heightFactor: fill / 100,
          // widthFactor: 0.012,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: mColor[moodVarient],
              shape: BoxShape.rectangle,
            ),
          ),
        ),
      ),
    );
  }
}
