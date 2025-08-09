import 'package:flutter/material.dart';
import 'package:huplyjoi/features/challenge/data/data.dart';
import 'package:huplyjoi/features/challenge/model/challenge.dart';
import 'widgets/challenge_card.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {

  void refresh(isCompleted, id){
    if(isCompleted) {
      final challenge = challenges.firstWhere((item) => id == item.id);
      setState(() {
        challenges.remove(challenge);
        challenges.add(
            Challenge(id: challenge.id,
                title: challenge.title,
                description: challenge.description,
                rewardPoints: challenge.rewardPoints,
                isCompleted: true)
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التحديات 🎯'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: challenges.map((c) => ChallengeCard(challenge: c, refresh as Function(bool, int))).toList(),
        ),
      ),
    );
  }
}