import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:mood_book/provider/data_provider.dart';
import 'package:mood_book/widgets/edit_description_widget.dart';

class CustomCalender extends ConsumerStatefulWidget {
  const CustomCalender({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CustomCalender();
  }
}

class _CustomCalender extends ConsumerState<CustomCalender>
    with TickerProviderStateMixin {
  late Future<void> _loadData;

  late AnimationController animController1;
  late AnimationController animController2;
  late AnimationController animController3;
  late AnimationController animController4;
  late AnimationController animController5;
  late AnimationController animController6;
  late AnimationController animController7;
  late AnimationController animController8;
  late AnimationController animController9;
  late AnimationController animController10;

  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  late Animation<double> animation5;
  late Animation<double> animation6;
  late Animation<double> animation7;
  late Animation<double> animation8;
  late Animation<double> animation9;
  late Animation<double> animation10;

  @override
  void initState() {
    super.initState();

    setState(() {
      _loadData = ref.read(dataProvider.notifier).getData();
    });

    animController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animController3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animController4 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animController5 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animController6 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animController7 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animController8 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animController9 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animController10 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    animation1 = Tween<double>(begin: 0, end: 1).animate(animController1);
    animation2 = Tween<double>(begin: 0, end: 1).animate(animController2);
    animation3 = Tween<double>(begin: 0, end: 1).animate(animController3);
    animation4 = Tween<double>(begin: 0, end: 1).animate(animController4);
    animation5 = Tween<double>(begin: 0, end: 1).animate(animController5);
    animation6 = Tween<double>(begin: 0, end: 1).animate(animController6);
    animation7 = Tween<double>(begin: 0, end: 1).animate(animController7);
    animation8 = Tween<double>(begin: 0, end: 1).animate(animController8);
    animation9 = Tween<double>(begin: 0, end: 1).animate(animController9);
    animation10 = Tween<double>(begin: 0, end: 1).animate(animController10);

    animController1.forward();
    animController1.addListener(() {
      if (animController1.isCompleted) {
        animController2.forward();
        animController1.reverse();
        animController2.addListener(() {
          if (animController2.isCompleted) {
            animController3.forward();
            animController2.reverse();
            animController3.addListener(() {
              if (animController3.isCompleted) {
                animController4.forward();
                animController3.reverse();
                animController4.addListener(() {
                  if (animController4.isCompleted) {
                    animController5.forward();
                    animController4.reverse();
                    animController5.addListener(() {
                      if (animController5.isCompleted) {
                        animController6.forward();
                        animController5.reverse();
                        animController6.addListener(() {
                          if (animController6.isCompleted) {
                            animController7.forward();
                            animController6.reverse();
                            animController7.addListener(() {
                              if (animation7.isCompleted) {
                                animController8.forward();
                                animController7.reverse();
                                animController8.addListener(() {
                                  if (animController8.isCompleted) {
                                    animController9.forward();
                                    animController8.reverse();
                                    animController9.addListener(() {
                                      if (animController9.isCompleted) {
                                        animController10.forward();
                                        animController9.reverse();
                                        animController10.addListener(() {
                                          if (animController10.isCompleted) {
                                            animController1.forward();
                                            animController10.reverse();
                                          }
                                        });
                                      }
                                    });
                                  }
                                });
                              }
                            });
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    animController1.dispose();
    animController2.dispose();
    animController3.dispose();
    animController4.dispose();
    animController5.dispose();
    animController6.dispose();
    animController7.dispose();
    animController8.dispose();
    animController9.dispose();
    animController10.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    List<MoodModel> data = ref
        .watch(dataProvider)
        .where((element) => int.parse(element.month) == date.month)
        .toList();
    // print(data);

    List<Widget> dates = [];

    final daysNum = switch (date.month) {
      1 => 31,
      2 => 29,
      3 => 31,
      4 => 30,
      5 => 31,
      6 => 30,
      7 => 31,
      8 => 31,
      9 => 30,
      10 => 31,
      11 => 30,
      12 => 31,
      // Add a wildcard pattern to handle other cases
      _ => 30,
    };

    int currentDateDay = 0;

    if (date.day - 1 > currentDateDay) {
      currentDateDay = date.day - 1;
    }

    void openDetails(File img, String description, MoodModel moodModel) {
      Widget imageBox = img.path == File("lib/assets/default_pic.jpeg").path
          ? Image.asset(
              "lib/assets/default_pic.jpeg",
              fit: BoxFit.cover,
            )
          : Image.file(
              img,
              fit: BoxFit.contain,
            );

      showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Stack(
            children: [
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(6),
                        height: 200,
                        width: double.infinity,
                        child: imageBox,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 40,
                          bottom: 80,
                        ),
                        child: EditDescripTion(
                          moodModel: moodModel,
                          description: description,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 80,
                right: 80,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text("close"),
                ),
              ),
            ],
          );
        },
      );
    }

    for (int i = 0; i <= daysNum - 1 - currentDateDay; i++) {
      Animation<double> usedAnimation = animation1;

      if (i == 2 || i == 7) {
        usedAnimation = animation2;
      } else if (i == 3 || i == 8 || i == 13) {
        usedAnimation = animation3;
      } else if (i == 4 || i == 9 || i == 14 || i == 19) {
        usedAnimation = animation4;
      } else if (i == 5 || i == 10 || i == 15 || i == 20 || i == 25) {
        usedAnimation = animation5;
      } else if (i == 6 ||
          i == 11 ||
          i == 16 ||
          i == 21 ||
          i == 26 ||
          i == 31) {
        usedAnimation = animation6;
      } else if (i == 12 || i == 17 || i == 22 || i == 27) {
        usedAnimation = animation7;
      } else if (i == 18 || i == 23 || i == 28) {
        usedAnimation = animation8;
      } else if (i == 24 || i == 29) {
        usedAnimation = animation9;
      } else if (i == 30) {
        usedAnimation = animation10;
      }

      dates.add(
        AnimatedBuilder(
          animation: usedAnimation,
          builder: (context, child) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor:
                  i >= data.length ? Colors.white : mColor[data[i].mood],
              onTap: () {
                if (i >= data.length) {
                  return;
                } else {
                  openDetails(
                    data[i].imgPath,
                    data[i].description,
                    data[i],
                  );
                }
              },
              child: Calender(
                date: currentDateDay + i + 1,
                // moodColor: Colors.green,
                moodColor: i >= data.length
                    ? const Color.fromARGB(0, 255, 255, 255)
                    : mColor[data[i].mood],
                animValue: 1 * usedAnimation.value,
              ),
            );
          },
        ),
      );
    }

    Widget content = data.isNotEmpty
        ? GridView(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6),
            children: [
              ...dates,
            ],
          )
        : Center(
            child: Text(
              "Please add some story",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );

    return Expanded(
      child: FutureBuilder(
        future: _loadData,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : content,
      ),
    );
  }
}

class Calender extends StatelessWidget {
  const Calender({
    super.key,
    this.date = 1,
    required this.moodColor,
    required this.animValue,
  });
  final int date;
  final Color moodColor;
  final double animValue;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewY(0.2),
      child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        height: 20,
        width: 20,
        transform: Transform.translate(
          offset: Offset(0, 10 * animValue),
        ).transform,
        decoration: BoxDecoration(
          color: moodColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: moodColor,
              blurRadius: 5,
              offset: const Offset(10, 10),
            )
          ],
        ),
        child: Transform(
          transform: Matrix4.skewY(0.2),
          child: Text(
            date.toString(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
          ),
        ),
      ),
    );
  }
}
