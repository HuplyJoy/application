import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:huplyjoi/features/goal/data/data.dart';
import 'package:huplyjoi/features/home/presentation/widgets/score_card.dart';

class UserProgressCard extends StatefulWidget {
  const UserProgressCard({super.key});

  @override
  State<UserProgressCard> createState() => _UserProgressCardState();
}

class _UserProgressCardState extends State<UserProgressCard> {

  int calculateXP() =>
      goals.where((g) => g.isCompleted).fold(0, (sum, g) => sum + g.points);


  @override
  Widget build(BuildContext context) {

    return Container(
      height: 135,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => context.go('/profile'),
                  child: Image.network(
                    "https://static.vecteezy.com/system/resources/previews/027/187/566/non_2x/hawk-sticker-transparent-free-png.png",
                    height: 70,
                    width: 70,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "رحالة",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                ScoreCard(title: 'منطقة', score: '1', icon: Icons.place),
                ScoreCard(
                  title: 'نقظة XP',
                  score: calculateXP().toString(),
                  icon: Icons.monetization_on,
                ),
                ScoreCard(
                  title: 'قطعة نادرة',
                  score: '0',
                  icon: Icons.account_balance,
                ),
                ScoreCard(title: 'هدف', score: '21', icon: Icons.flag),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
