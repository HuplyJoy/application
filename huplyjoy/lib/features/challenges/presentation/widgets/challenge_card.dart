import 'package:flutter/material.dart';
import 'package:huplyjoi/features/challenges/model/challenge.dart';
import 'package:huplyjoi/features/goal/presentation/goal_screen.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard(this.refresh, {super.key, required this.challenge});

  final Challenge challenge;
  final Function(bool, int) refresh;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          challenge.title,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            challenge.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.green.shade100),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              challenge.isCompleted ? Icons.check_circle : Icons.flag_outlined,
              color: challenge.isCompleted ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text('+${challenge.rewardPoints} XP'),
          ],
        ),
        onTap: () async {
          final bool isCompleted = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GoalScreen(challenge.title, challenge.id),
            ),
          )?? false;

          refresh(isCompleted, challenge.id);
        },
      ),
    );
  }
}
