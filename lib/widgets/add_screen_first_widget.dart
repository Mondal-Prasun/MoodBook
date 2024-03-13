import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:mood_book/provider/data_provider.dart';

class ScrollableMoodCards extends ConsumerStatefulWidget {
  const ScrollableMoodCards({super.key});
  @override
  ConsumerState<ScrollableMoodCards> createState() {
    return _ScrollableMoodCardsState();
  }
}

class _ScrollableMoodCardsState extends ConsumerState<ScrollableMoodCards> {
  late final ScrollController _scrollController;
  final description = TextEditingController();

  MoodVarient moodState = MoodVarient.happy;
  Color moodColor = mColor[MoodVarient.happy];
  XFile? imagePath;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      _changeMoodState();
    });
  }

  @override
  void dispose() {
    description.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _changeMoodState() {
    // print("Something ${_scrollController.position.pixels.floor()}");
    setState(() {
      int scrollValue = _scrollController.position.pixels.floor();

      if (scrollValue > 133 && scrollValue < 266) {
        moodState = MoodVarient.sad;
        moodColor = mColor[MoodVarient.sad];
      } else if (scrollValue > 266 && scrollValue < 399) {
        moodState = MoodVarient.angry;
        moodColor = mColor[MoodVarient.angry];
      } else if (scrollValue > 399 && scrollValue < 532) {
        moodState = MoodVarient.fear;
        moodColor = mColor[MoodVarient.fear];
      } else if (scrollValue > 532 && scrollValue < 665) {
        moodState = MoodVarient.surprise;
        moodColor = mColor[MoodVarient.surprise];
      } else if (scrollValue > 665 && scrollValue <= 798) {
        moodState = MoodVarient.disgust;
        moodColor = mColor[MoodVarient.disgust];
      } else {
        moodState = MoodVarient.happy;
        moodColor = mColor[MoodVarient.happy];
      }
      // print(moodState);
    });
  }

  void _saveData() {
    if (description.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          content: const Text("Description is required"),
        ),
      );
      return;
    }

    if (imagePath == null) {
      ref.read(dataProvider.notifier).addData(
            MoodModel(
              mood: moodState,
              description: description.text,
            ),
          );
    } else {
      File imagesPath = File(imagePath!.path);

      if (imagesPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            content: const Text("Something went wrong"),
          ),
        );
        return;
      } else {
        ref.read(dataProvider.notifier).addData(
              MoodModel(
                mood: moodState,
                description: description.text,
                imgPath: imagesPath,
              ),
            );
      }
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("story added"),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }

  void _choosePicture() async {
    try {
      ImagePicker picker = ImagePicker();
      final pickedImages = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 200,
        maxWidth: double.infinity,
      );

      if (pickedImages != null) {
        setState(() {
          imagePath = pickedImages;
        });
      }
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? preview;

    if (imagePath == null) {
      preview = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.photo_album,
              color: Colors.white,
            ),
            onPressed: _choosePicture,
          ),
          Text(
            "Pick any Picture of today's memory",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          Text(
            "(Optional)",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      );
    } else {
      preview = SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Container(
          // width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Image.file(
            File(imagePath!.path),
            width: double.infinity,
          ),
        ),
      );
    }

    List<Widget> moodCards = [
      Card(
        color: Theme.of(context).colorScheme.background,
        child: Lottie.asset(
          moodemojis[MoodVarient.happy],
          height: 150,
          width: 150,
        ),
      ),
      Card(
        color: Theme.of(context).colorScheme.background,
        child: Lottie.asset(
          moodemojis[MoodVarient.sad],
          height: 150,
          width: 150,
        ),
      ),
      Card(
        color: Theme.of(context).colorScheme.background,
        child: Lottie.asset(
          moodemojis[MoodVarient.angry],
          height: 150,
          width: 150,
        ),
      ),
      Card(
        color: Theme.of(context).colorScheme.background,
        child: Lottie.asset(
          moodemojis[MoodVarient.fear],
          height: 150,
          width: 150,
        ),
      ),
      Card(
        color: Theme.of(context).colorScheme.background,
        child: Lottie.asset(
          moodemojis[MoodVarient.surprise],
          height: 150,
          width: 150,
        ),
      ),
      Card(
        color: Theme.of(context).colorScheme.background,
        child: Lottie.asset(
          moodemojis[MoodVarient.disgust],
          height: 150,
          width: 150,
        ),
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 200,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: description,
              cursorColor: Colors.white,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: "Enter Description!",
                hintStyle: TextStyle(
                  color: Color.fromARGB(173, 255, 255, 255),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        ...moodCards,
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                "←_← Swipe",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          AnimatedContainer(
            height: 40,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: moodColor,
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(milliseconds: 300),
            child: Text(
              moodState.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
            ),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: _choosePicture,
              child: preview,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    titleTextStyle:
                        Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                    contentTextStyle:
                        Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                    title: const Text("Are you sure?"),
                    content: const Text("All unsaved things will be deleted!!"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("No")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Yes")),
                    ],
                  ),
                ),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _saveData,
                child: const Text("Save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
