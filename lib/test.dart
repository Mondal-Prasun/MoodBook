import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:mood_book/notification_controller.dart';

class Example extends StatefulWidget {
  const Example({super.key});
  @override
  State<Example> createState() {
    return _ExampleState();
  }
}

class _ExampleState extends State<Example> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                AwesomeNotifications().createNotification(
                  content: NotificationContent(
                    id: 1,
                    channelKey: "Channel 1",
                    title: "From MoodBook",
                    body: "Time to tell me about your day!Come..",
                    wakeUpScreen: true,
                    // category: NotificationCategory.Reminder,
                  ),
                  schedule: NotificationInterval(
                    interval: 60,
                    allowWhileIdle: true,
                    repeats: true,
                    preciseAlarm: true,
                    timeZone: AwesomeNotifications.localTimeZoneIdentifier,
                  ),
                  // schedule: NotificationAndroidCrontab.minutely(
                  //     referenceDateTime: DateTime.now(), allowWhileIdle: true),
                );
              },
              child: Text("simple notification")),
        ],
      ),
    );
  }
}
