import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:mood_book/provider/data_provider.dart';
import 'package:mood_book/widgets/chart_bar_widget.dart';

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
    List<MoodModel> allData = ref.watch(dataProvider);

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
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 3,
                  ),
                  left: BorderSide(
                    color: Colors.black,
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
                        style: Theme.of(context).textTheme.titleMedium,
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
          )
        ],
      ),
    );
  }
}
