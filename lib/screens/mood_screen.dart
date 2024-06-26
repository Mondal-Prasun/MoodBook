import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:mood_book/notification_controller.dart';
import 'package:mood_book/provider/data_provider.dart';
import 'package:mood_book/screens/add_mood_screen.dart';
import 'package:mood_book/screens/chart_screen.dart';
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
  final todaysDate = DateTime.now();
  bool canEnterMood = true;
  int _currentIndex = 0;

  void showNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "Channel 1",
        title: "From MoodBook",
        body: "Time to tell me about your day!Come..",
        wakeUpScreen: true,
        // category: NotificationCategory.Reminder,
      ),
      schedule: NotificationInterval(
        interval: 60 * 60 * 24,
        allowWhileIdle: true,
        repeats: true,
        preciseAlarm: true,
        timeZone: AwesomeNotifications.localTimeZoneIdentifier,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ref.read(dataProvider.notifier).getData();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
    showNotification();
  }

  @override
  Widget build(BuildContext context) {
    List<MoodModel> moodList = ref.watch(dataProvider);

    if (moodList.isNotEmpty) {
      MoodModel lastDayMood = moodList[moodList.length - 1];
      if (int.parse(lastDayMood.day) == todaysDate.day &&
          int.parse(lastDayMood.month) == todaysDate.month) {
        canEnterMood = false;
      }
    }

    void onTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    Widget mainContent = switch (_currentIndex) {
      0 => Column(children: [
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
      1 => const ChartScreen(),
      2 => Center(
          child: Column(
            children: [
              Lottie.asset(
                "lib/assets/pet.json",
              ),
              Text(
                "Coming Soon",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              )
            ],
          ),
        ),
      _ => throw Error(),
    };

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
        currentIndex: _currentIndex,
        onTap: onTapped,
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          toolbarHeight: _currentIndex == 0 ? 220 : null,
          title: switch (_currentIndex) {
            0 => MoodCard(
                data: moodList,
              ),
            1 => const Center(
                child: Text("Mood Chart"),
              ),
            2 => const Center(
                child: Text("Pet"),
              ),
            _ => throw Error(),
          }),
      body: mainContent,
    );
  }
}
