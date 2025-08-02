import 'package:huplyjoi/features/home/model/landmark.dart';
import 'package:huplyjoi/features/home/presentation/widgets/user_progress_card.dart';
import 'widgets/area_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchText = TextEditingController();
  final List<Area> _mockLandmarks = [
    Area(
      id: '1',
      name: 'قرية رجال ألمع',
      description: 'عسير منطقة جبلية تقع في جنوب غرب المملكة العربية السعودية، تشتهر بطبيعتها الخلابة، وأجوائها المعتدلة، وتراثها الثقافي الغني.',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/ar/8/8b/Rijal_alma_15-11-2008.jpg?20081206132600',
      location: 'عسير',
      isCompleted: false,
      rewardPoints: 400,
    ),

  ];
  List<Area> _filteredList = [];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("مرحباً بك 👋"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            UserProgressCard(),
            Container(
              margin: EdgeInsets.only(top: 24 ),
              height:40,
              child: SearchBar(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20,
                  )
                ),
                leading: Icon(Icons.search),
                hintText: "البحث عن معلم",
                controller: _searchText,
                onChanged: (searchText){
                  setState(() {
                    _filteredList = _mockLandmarks.where(
                            (landmark) =>
                        landmark.name.contains(searchText.trim()) ||
                            landmark.description.contains(searchText.trim()) ||
                            landmark.location.contains(searchText.trim())
                    ).toList();
                  });
                },
              ),
            ),
            SizedBox(height: 12,),
            const Text(
              "اكتشف معالم السعودية 🇸🇦",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            for (var landmark in _searchText.text.trim().isEmpty ? _mockLandmarks:_filteredList) AreaCard(landmark),
          ],
        ),
      ),
    );
  }
}
