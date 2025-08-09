import 'package:flutter/material.dart';
import 'package:huplyjoi/features/challenge/presentation/challenge_screen.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black26,
              width: double.infinity,
              height: 450,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/story_imgs/$_index.PNG',
                fit: BoxFit.fill,
                height: double.infinity,
              ),
            ),
          ),
          Container(
            color: Colors.black,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_index < 7) {
                      setState(() {
                        _index += 1;
                      });
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ChallengeScreen()),
                      );

                    }
                  },
                  child: Text('التالي'),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ChallengeScreen()),
                    );
                  },
                  child: Text('تخطي'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
