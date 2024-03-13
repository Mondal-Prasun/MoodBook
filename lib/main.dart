import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_book/screens/first_screen.dart';

import 'package:mood_book/widgets/splash_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelGroupKey: "Channelgroupkey",
      channelKey: "Channel 1",
      channelName: "First Channel",
      channelDescription: "This is channel description",
      defaultColor: const Color.fromARGB(158, 255, 153, 0),
    ),
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "Channelgroupkey", channelGroupName: "someName"),
  ]);
  bool isSendingNotificationAllowed =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isSendingNotificationAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _isOkayed;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // This widget is the root of your application

  @override
  void initState() {
    super.initState();
    _isOkayed = _prefs.then((pref) => pref.getBool("isOkeyed") ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.brown,
            background: const Color.fromARGB(158, 255, 153, 0),
            onPrimaryContainer: Colors.red,
          ),
          textTheme: TextTheme(
            titleLarge: GoogleFonts.acme(),
          ),
        ),
        home: FutureBuilder(
          future: _isOkayed,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.data == false) {
              return const FirstScreen();
            } else {
              return const SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
