import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_book/screens/book_screen.dart';

class MoodCard extends StatefulWidget {
  const MoodCard({
    super.key,
    this.avatarImg = "lib/assets/avatar.png",
    this.userName = "User User",
  });
  final String avatarImg;
  final String userName;
  @override
  State<MoodCard> createState() {
    return _MoodCardState();
  }
}

class _MoodCardState extends State<MoodCard> with TickerProviderStateMixin {
  String moodAnimation = "lib/assets/happy.json";

  @override
  Widget build(BuildContext context) {
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookScreen(bookName: "Book Name"),
                      ));
                    },
                    icon: Icon(
                      Icons.menu_book,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Lottie.asset(
                    moodAnimation,
                    height: 150,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    backgroundImage: AssetImage(widget.avatarImg),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
