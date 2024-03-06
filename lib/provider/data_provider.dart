import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:mood_book/model/dummy.dart';
import 'package:mood_book/model/mood_model.dart';
import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart' as syspath;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatebase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, "moods.db"),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE mood_dates(id TEXT PRIMARY KEY, day TEXT, month TEXT, year TEXT, description TEXT, mood TEXT,imgPath TEXT)",
      );
    },
    version: 1,
  );

  return db;
}

class DataNotifier extends StateNotifier<List<MoodModel>> {
  DataNotifier() : super([]);

  Future<void> getData() async {
    final db = await _getDatebase();
    final dbData = await db.query("mood_dates");
    // print(dbData);

    final List<MoodModel> moodData = [];

    for (final item in dbData) {
      moodData.add(
        MoodModel(
          mood: MoodVarient.values.byName(
            item["mood"] as String,
          ),
          id: item["id"] as String,
          day: item["day"] as String,
          month: item["month"] as String,
          year: item["year"] as String,
          description: item["description"] as String,
          imgPath: File(
            item["imgPath"] as String,
          ),
        ),
      );
    }
    state = moodData;
  }

  void addData(MoodModel moodModel) async {
    final db = await _getDatebase();

    db.insert("mood_dates", {
      "id": moodModel.id,
      "day": moodModel.day.toString(),
      "month": moodModel.month.toString(),
      "year": moodModel.year.toString(),
      "description": moodModel.description,
      "mood": moodModel.mood.name,
      "imgPath": moodModel.imgPath.path,
    });

    state = [...state, moodModel];
  }

  void saveEditText(MoodModel moodModel, String editedText) async {
    final db = await _getDatebase();
    Map<String, dynamic> updatedItem = {
      "day": moodModel.day.toString(),
      "month": moodModel.month.toString(),
      "year": moodModel.year.toString(),
      "description": editedText,
      "mood": moodModel.mood.name,
      "imgPath": moodModel.imgPath.path,
    };
    final something = await db.update(
      "mood_dates",
      updatedItem,
      where: "id = ?",
      whereArgs: [moodModel.id],
    );
  }
}

final dataProvider = StateNotifierProvider<DataNotifier, List<MoodModel>>(
  (ref) => DataNotifier(),
);
