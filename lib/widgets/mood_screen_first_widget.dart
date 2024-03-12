import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:mood_book/screens/book_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodCard extends StatefulWidget {
  const MoodCard({
    super.key,
    // this.avatarImg = "lib/assets/avatar.png",
    // this.userName = "User User",
    required this.data,
  });
  // final String avatarImg;
  // final String userName;
  final List<MoodModel> data;
  @override
  State<MoodCard> createState() {
    return _MoodCardState();
  }
}

class _MoodCardState extends State<MoodCard> with TickerProviderStateMixin {
  String moodAnimation = "lib/assets/happy.json";
  final date = DateTime.now();
  late Future<String> userName;
  late Future<String> userBookName;
  late Future<String> userImg;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    userName = _prefs.then((pref) => pref.getString("userName") ?? "user");
    userBookName =
        _prefs.then((pref) => pref.getString("userBookName") ?? "userBookName");
    userImg = _prefs
        .then((pref) => pref.getString("userImg") ?? "lib/assets/avatar.png");
  }

  @override
  Widget build(BuildContext context) {
    int happy = 0;
    int sad = 0;
    int angry = 0;
    int fear = 0;
    int surprise = 0;
    int disgust = 0;

    for (int i = 0; i < widget.data.length; i++) {
      if (int.parse(widget.data[i].month) == date.month) {
        switch (widget.data[i].mood) {
          case MoodVarient.happy:
            happy++;
            break;
          case MoodVarient.sad:
            sad++;
            break;
          case MoodVarient.angry:
            angry++;
            break;
          case MoodVarient.fear:
            fear++;
            break;
          case MoodVarient.surprise:
            surprise++;
            break;
          case MoodVarient.disgust:
            disgust++;
            break;

          default:
            throw Error();
        }
      }
    }

    if (happy > sad &&
        happy > angry &&
        happy > fear &&
        happy > surprise &&
        happy > disgust) {
      moodAnimation = "lib/assets/happy.json";
    } else if (sad > happy &&
        sad > angry &&
        sad > fear &&
        sad > surprise &&
        sad > disgust) {
      moodAnimation = "lib/assets/sad.json";
    } else if (angry > happy &&
        angry > sad &&
        angry > fear &&
        angry > surprise &&
        angry > disgust) {
      moodAnimation = "lib/assets/angry.json";
    } else if (fear > happy &&
        fear > sad &&
        fear > angry &&
        fear > surprise &&
        fear > disgust) {
      moodAnimation = "lib/assets/fear.json";
    } else if (surprise > happy &&
        surprise > sad &&
        surprise > angry &&
        surprise > fear &&
        surprise > disgust) {
      moodAnimation = "lib/assets/surprised.json";
    } else if (disgust > happy &&
        disgust > sad &&
        disgust > angry &&
        disgust > fear &&
        disgust > surprise) {
      moodAnimation = "lib/assets/disgust.json";
    } else {
      moodAnimation = "lib/assets/happy.json";
    }

    return Card(
      margin: const EdgeInsets.only(
        top: 15,
      ),
      // elevation: 7,
      child: SizedBox(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    //to open life book button
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FutureBuilder(
                            future: userBookName,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError ||
                                  snapshot.data == "userBookName") {
                                return BookScreen(bookName: snapshot.data!);
                              } else {
                                return BookScreen(bookName: snapshot.data!);
                              }
                            },
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.menu_book,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const Spacer(),
                Lottie.asset(
                  moodAnimation,
                  height: 150,
                  width: 120,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FutureBuilder(
                    future: userImg,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError ||
                          snapshot.data == "lib/assets/avatar.png") {
                        return const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red,
                          backgroundImage: AssetImage("lib/assets/avatar.png"),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red,
                          backgroundImage: FileImage(
                            File(snapshot.data!),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: userName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError || snapshot.data == "user") {
                  return Text(
                    snapshot.data!,
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                } else {
                  return Text(
                    snapshot.data!,
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
