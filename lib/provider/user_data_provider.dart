import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserData {
  const UserData(
      {required this.name, required this.bookName, required this.img});
  final String name;
  final File img;
  final String bookName;
}

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier()
      : super(
          UserData(
            name: "User",
            bookName: "User book",
            img: File("default"),
          ),
        );
}
