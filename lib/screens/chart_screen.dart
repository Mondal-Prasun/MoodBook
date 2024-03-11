import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:mood_book/provider/data_provider.dart';
import 'package:mood_book/widgets/chart_bar_widget.dart';
import 'package:mood_book/widgets/pie_chart_widget.dart';

class ChartScreen extends ConsumerStatefulWidget {
  const ChartScreen({super.key});
  @override
  ConsumerState<ChartScreen> createState() {
    return _ChartScreenState();
  }
}

class _ChartScreenState extends ConsumerState<ChartScreen> {
  late Future<void> _loadData;

  @override
  void initState() {
    super.initState();

    _loadData = ref.read(dataProvider.notifier).getData();
  }

  @override
  Widget build(BuildContext context) {
    List<MoodModel> moodData = ref.watch(dataProvider);
    List<MoodModel> allData = [];
    final todaysDate = DateTime.now();

    for (int i = 0; i < moodData.length; i++) {
      if (int.parse(moodData[i].month) == todaysDate.month) {
        allData.add(moodData[i]);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 20,
            ),
            child: Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3,
                  ),
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.background,
                    width: 3,
                  ),
                ),
              ),
              alignment: Alignment.bottomLeft,
              child: allData.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (int i = 0; i < allData.length; i++)
                          ChartBar(moodVarient: allData[i].mood),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Please add some story",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  allData.isEmpty ? "0" : "1",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  allData.length.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ListTile(
                        leading: ColoredBox(
                          color: mColor[MoodVarient.happy],
                          child: const SizedBox(
                            height: 18,
                            width: 18,
                          ),
                        ),
                        title: Text(
                          "Happy",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      ListTile(
                        leading: ColoredBox(
                          color: mColor[MoodVarient.sad],
                          child: const SizedBox(
                            height: 18,
                            width: 18,
                          ),
                        ),
                        title: Text(
                          "Sad",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      ListTile(
                        leading: ColoredBox(
                          color: mColor[MoodVarient.angry],
                          child: const SizedBox(
                            height: 18,
                            width: 18,
                          ),
                        ),
                        title: Text(
                          "Angry",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      ListTile(
                        leading: ColoredBox(
                          color: mColor[MoodVarient.fear],
                          child: const SizedBox(
                            height: 18,
                            width: 18,
                          ),
                        ),
                        title: Text(
                          "Fear",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      ListTile(
                        leading: ColoredBox(
                          color: mColor[MoodVarient.surprise],
                          child: const SizedBox(
                            height: 18,
                            width: 18,
                          ),
                        ),
                        title: Text(
                          "Surprised",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      ListTile(
                        leading: ColoredBox(
                          color: mColor[MoodVarient.disgust],
                          child: const SizedBox(
                            height: 18,
                            width: 18,
                          ),
                        ),
                        title: Text(
                          "Disgust",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: allData.isEmpty
                      ? Text(
                          "please add today's story",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: MoodPieChart(
                            mooddata: allData,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
