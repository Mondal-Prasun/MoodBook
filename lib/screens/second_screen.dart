import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mood_book/screens/mood_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _fromKey = GlobalKey<FormState>();
  String? userName;
  String? userBookName;
  String? userImg;

  void pickImage() async {
    ImagePicker picker = ImagePicker();
    final pickedImg = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      try {
        userImg = pickedImg!.path;
      } catch (e) {
        print(e);
      }
    });
  }

  void onSave() async {
    if (_fromKey.currentState!.validate() && userImg != null) {
      _fromKey.currentState!.save();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          content: const Text("Image & Name is mandetory"),
        ),
      );
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (userName != null && userBookName != null && userImg != null) {
      await prefs.setString("userName", userName!);
      await prefs.setString("userBookName", userBookName!);
      prefs.setString("userImg", userImg!).then(
            (value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MoodScreen(),
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Center(
          child: Text(
            "Some details",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Form(
            key: _fromKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: pickImage,
                    child: userImg == null
                        ? Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.background,
                            ),
                            child: const Icon(Icons.image))
                        : CircleAvatar(
                            radius: 80,
                            backgroundImage: FileImage(
                              File(userImg!),
                            ),
                          ),
                  ),
                  const Text("Choose your photo"),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter your Full Name",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: TextFormField(
                      maxLength: 20,
                      decoration: const InputDecoration(
                        hintText: "Full Name",
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.length < 3 ||
                            value.isEmpty) {
                          return "Please enter valid name which is atleast 3 charecter long";
                        }
                        return null;
                      },
                      onSaved: (newValue) => userName = newValue,
                    ),
                  ),
                  Text(
                    "Enter Your own story book name",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: TextFormField(
                      maxLength: 20,
                      decoration: const InputDecoration(
                        hintText: "Book Name",
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.length <= 3 ||
                            value.isEmpty) {
                          return "Please enter valid name which is atleast 3 charecter long";
                        }
                        return null;
                      },
                      onSaved: (newValue) => userBookName = newValue,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.background,
                    ),
                    child: Text(
                      "Submit",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
