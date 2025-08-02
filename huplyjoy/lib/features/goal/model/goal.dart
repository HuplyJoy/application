import 'package:latlong2/latlong.dart';

class Goal {
  final int challengeId;
  final String title;
  final String description;
  final String image;
  final int points;
  final LatLng location;
  final bool isCompleted;
  final String qr;

  Goal({
    required this.challengeId,
    required this.title,
    required this.description,
    required this.image,
    required this.points,
    required this.location,
    required this.isCompleted,
    required this.qr,
  });
}