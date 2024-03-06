import 'package:flutter/material.dart';
import 'package:mood_book/widgets/mood_screen_second_calender.dart';

class MoodDate extends StatefulWidget {
  const MoodDate({super.key});
  @override
  State<MoodDate> createState() {
    return _MoodDateState();
  }
}

class _MoodDateState extends State<MoodDate> {
  final date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final String todayDate = "${date.day}/${date.month}/${date.year}";
    final String currentMonth = switch (date.month) {
      1 => "January",
      2 => "February",
      3 => "March",
      4 => "April",
      5 => "May",
      6 => "June",
      7 => "July",
      8 => "August",
      9 => "September",
      10 => "October",
      11 => "November",
      12 => "December",
      // Add a wildcard pattern to handle other cases
      _ => "Unknown Month",
    };

    return Card(
      margin: const EdgeInsets.all(15),
      child: SizedBox(
        width: double.infinity,
        height: 425,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                    left: 10,
                  ),
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    todayDate,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(top: 15, right: 10),
                  width: 150,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    currentMonth,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const CustomCalender(),
          ],
        ),
      ),
    );
  }
}
