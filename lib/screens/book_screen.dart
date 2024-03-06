import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:mood_book/provider/data_provider.dart';

class BookScreen extends ConsumerStatefulWidget {
  const BookScreen({super.key, required this.bookName});
  final String bookName;
  @override
  ConsumerState<BookScreen> createState() {
    return _BookScreenState();
  }
}

class _BookScreenState extends ConsumerState<BookScreen> {
  @override
  void initState() {
    ref.read(dataProvider.notifier).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MoodModel> allData = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Text(
            widget.bookName,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allData.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            color: Theme.of(context).colorScheme.background,
            child: Details(
              moodModel: allData[index],
            ),
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({super.key, required this.moodModel});
  final MoodModel moodModel;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Widget imageBox =
        moodModel.imgPath.path == File("lib/assets/default_pic.jpeg").path
            ? Image.asset(
                "lib/assets/default_pic.jpeg",
                fit: BoxFit.cover,
              )
            : Image.file(
                moodModel.imgPath,
                fit: BoxFit.contain,
              );

    return SizedBox(
      height: size.height,
      width: size.width - 20,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 200,
              width: double.infinity,
              child: imageBox,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "${moodModel.day}/${moodModel.month}/${moodModel.year}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                moodModel.description,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
