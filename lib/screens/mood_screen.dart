import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:mood_book/provider/data_provider.dart';
import 'package:mood_book/screens/add_mood_screen.dart';
import 'package:mood_book/widgets/mood_screen_first_widget.dart';
import 'package:mood_book/widgets/mood_screen_second_date.dart';

class MoodScreen extends ConsumerStatefulWidget {
  const MoodScreen({super.key});
  @override
  ConsumerState<MoodScreen> createState() {
    return _MoodScreenState();
  }
}

class _MoodScreenState extends ConsumerState<MoodScreen> {
  @override
  Widget build(BuildContext context) {
    List<MoodModel> moodList = ref.watch(dataProvider);
    final todaysDate = DateTime.now();
    bool canEnterMood = true;

    // if (moodList.isNotEmpty) {
    //   MoodModel lastDayMood = moodList[moodList.length - 1];
    //   if (int.parse(lastDayMood.day) == todaysDate.day &&
    //       int.parse(lastDayMood.month) == todaysDate.month) {
    //     canEnterMood = false;
    //   }
    // }

    return Scaffold(
      //todo for later update
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_sharp),
            label: "Chart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: "Pet",
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        toolbarHeight: 220,
        title: const MoodCard(),
      ),
      body: Column(children: [
        const MoodDate(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.green,
          ),
          onPressed: () {
            if (canEnterMood == false) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Lottie.asset(
                    "lib/assets/wait.json",
                    height: 150,
                    width: 150,
                  ),
                  content: Text(
                    "You can add again tommrow (You can add or edit description by tapping any of the dates..)",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    ),
                  ],
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddMoods(),
                ),
              );
            }
          },
          child: canEnterMood == false
              ? const Icon(Icons.lock)
              : const Text("add today's story"),
        ),
      ]),
    );
  }
}
