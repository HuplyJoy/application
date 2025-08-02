import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.title, required this.score, required this.icon});

  final String title;
  final String score;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // or use MediaQuery for responsive
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).colorScheme.primary.withAlpha(20),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Text(score), Spacer(), Icon(icon, size: 20)]),
            SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
