import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Example extends StatefulWidget {
  const Example({super.key});
  @override
  State<Example> createState() {
    return _ExampleState();
  }
}

class _ExampleState extends State<Example> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _count;

  Future<void> counter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt("counter") ?? 0) + 1;
    setState(() {
      _count = prefs.setInt("counter", counter).then((value) => counter);
    });
  }

  @override
  void initState() {
    super.initState();
    _count = _prefs.then((prefs) => prefs.getInt("counter") ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: counter,
              child: Text(
                "press",
              ),
            ),
            FutureBuilder(
              future: _count,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return Text("${snapshot.data}");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
