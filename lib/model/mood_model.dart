import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum MoodVarient {
  happy,
  sad,
  angry,
  fear,
  surprise,
  disgust,
}

final Map mColor = {
  MoodVarient.happy: Colors.green,
  MoodVarient.sad: Colors.blue,
  MoodVarient.angry: Colors.red,
  MoodVarient.surprise: Colors.pink,
  MoodVarient.fear: Colors.yellow,
  MoodVarient.disgust: Colors.purple,
};

final Map moodemojis = {
  MoodVarient.happy: "lib/assets/happy.json",
  MoodVarient.sad: "lib/assets/sad.json",
  MoodVarient.fear: "lib/assets/fear.json",
  MoodVarient.angry: "lib/assets/angry.json",
  MoodVarient.surprise: "lib/assets/surprised.json",
  MoodVarient.disgust: "lib/assets/disgust.json",
};

class MoodModel {
  MoodModel({
    required this.mood,
    this.description = "Default",
    File? imgPath,
    String? id,
    String? day,
    String? month,
    String? year,
  })  : id = id ?? const Uuid().v4(),
        day = day ?? DateTime.now().day.toString(),
        month = month ?? DateTime.now().month.toString(),
        year = year ?? DateTime.now().year.toString(),
        imgPath = imgPath ?? File("lib/assets/default_pic.jpeg");
  final String id;
  final MoodVarient mood;
  final File imgPath;
  final String description;
  final String day;
  final String month;
  final String year;
}
