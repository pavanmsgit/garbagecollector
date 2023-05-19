import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Notifications> notificationsFromJson(str) =>
    List<Notifications>.from((str).map((x) => Notifications.fromJson(x.data())));

String notificationsToJson(List<Notifications> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
  DocumentReference<Object?>? reference;

  Notifications({
    required this.notificationId,
    required this.title,
    required this.description,
    required this.area,
    required this.time,
  });

  late String notificationId;
  late String title;
  late String description;
  late String area;
  late Timestamp time;


  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        notificationId: json["notificationId"],
        title: json["title"],
        description: json["description"],
        area: json["area"],
        time: json["time"]
      );

  Map<String, dynamic> toJson() => {
        "notificationId": notificationId,
        "title": title,
        "description": description,
        "area": area,
        "time": time
      };

  Notifications.fromMap(json, {this.reference}) {
    notificationId = json["notificationId"];
    title = json["title"];
    description = json["description"];
    area = json["area"];
    time = json["time"];
  }

  Notifications.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
