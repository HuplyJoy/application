import 'package:flutter/material.dart';
import 'package:huplyjoi/features/challenge/presentation/challenge_screen.dart';
import 'package:huplyjoi/features/home/model/landmark.dart';
import 'package:huplyjoi/features/story/presentation/story_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AreaCard extends StatefulWidget {
  const AreaCard(this.area, {super.key});
  final Area area;

  @override
  State<AreaCard> createState() => _AreaCardState();
}

class _AreaCardState extends State<AreaCard> {
  bool hasShownSplash = false;

  @override
  void initState() {
    super.initState();
    _loadSplashStatus();
  }

  Future<void> _loadSplashStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      hasShownSplash = prefs.getBool('hasShownSplash') ?? false;
    });
  }

  Future<void> _onButtonPressed() async {
    if (!hasShownSplash) {
      // عرض Splash
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => StoryScreen()),
      );

      // حفظ الحالة
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasShownSplash', true);

      setState(() {
        hasShownSplash = true;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => ChallengeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child:
        InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: _onButtonPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                widget.area.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.area.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.area.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha(150)),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 18, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(widget.area.location, style: const TextStyle(fontSize: 14)),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            widget.area.isCompleted ? Icons.check_circle : Icons.flag_outlined,
                            color: widget.area.isCompleted ? Colors.green : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(height: 2),
                          Text('+${widget.area.rewardPoints} XP', style: TextStyle(fontSize: 10, color: Colors.white70),),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}