import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:huplyjoi/features/goal/data/data.dart';
import 'package:huplyjoi/features/goal/model/goal.dart';
import 'package:huplyjoi/features/goal/presentation/q_r_scaneer_screen.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen(this.pageTitle, this.id, {super.key});
  final String pageTitle;
  final int id;

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  LatLng? userLocation;
  final String mapTilerApiKey = 'vVYPEaYcAfGCzAvjCnKk';
  final MapController _mapController = MapController();

  List<Goal> goals_list = [];

  @override
  void initState() {
    goals_list = goals.where((item) => item.challengeId == widget.id).toList();
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final permission = await Permission.location.request();
    if (permission.isGranted) {
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });
    } else {
      // fallback to Jeddah
      setState(() {
        userLocation = LatLng(21.543333, 39.172778);
      });
    }
  }

  void requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final String result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => QRScannerScreen()),
      );
      if (result.trim().isNotEmpty &&
          result.contains(
            'https://huplejoy.com', // change it to your own domain
          )
          ) {
        final Goal goal = goals.firstWhere((item) => item.qr == result);
        setState(() {
          goals.remove(goal);
          goals.add(
            Goal(
              challengeId: goal.challengeId,
              title: goal.title,
              description: goal.description,
              image: goal.image,
              points: goal.points,
              location: goal.location,
              isCompleted: true,
              qr: goal.qr,
            ),
          );
          goals_list = goals.where((item) => item.challengeId == widget.id).toList();
        });
        final completedGoals = goals_list.where((item)=> item.isCompleted == true).length;
        final completedChallenges = goals_list.length;
        final bool isOk = completedGoals == completedChallenges;

        if(isOk){
          Navigator.pop(context, isOk);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ارجع نام الكود الذي مسحته خطاء')),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('ليس لدي صلاحية فتح الكاميرة')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pageTitle), centerTitle: true),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional(0.95, -0.95),
            children: [
              SizedBox(
                height: 380,
                child:
                    userLocation == null
                        ? const Center(child: CircularProgressIndicator())
                        : FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter: userLocation!,
                            initialZoom: 15.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://api.maptiler.com/maps/openstreetmap/{z}/{x}/{y}.jpg?key=$mapTilerApiKey',
                              userAgentPackageName: 'com.example.yourapp',
                            ),
                            MarkerLayer(
                              markers: [
                                // Marker لموقع المستخدم
                                Marker(
                                  point: userLocation!,
                                  width: 40,
                                  height: 40,
                                  child: const Icon(
                                    Icons.my_location,
                                    color: Colors.blue,
                                    size: 35,
                                  ),
                                ),
                                // Markers للتحديات
                                ...goals.map((challenge) {
                                  return Marker(
                                    point: challenge.location,
                                    width: 40,
                                    height: 40,
                                    child: Tooltip(
                                      message: challenge.title,
                                      child: const Icon(
                                        Icons.flag,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ],
                        ),
              ),
              IconButton.filled(
                padding: EdgeInsets.all(12),
                icon: Icon(Icons.camera_alt),
                onPressed: requestCameraPermission,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: goals_list.length,
              itemBuilder: (context, index) {
                final goal = goals_list[index];
                return ListTile(
                  title: Text(
                    goal.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    goal.description,
                    style: TextStyle(fontSize: 12),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(goal.image),
                  ),
                  trailing: SizedBox(
                    width: 73,
                    child: Row(
                      children: [
                        Text(' +${goal.points} XP '),
                        Icon(
                          goal.isCompleted
                              ? Icons.check_circle
                              : Icons.flag_circle,
                          color:
                          goal.isCompleted
                                  ? Colors.green
                                  : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    final LatLng targetLocation = goal.location;
                    _mapController.move(targetLocation, 17.0);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
