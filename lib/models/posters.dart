///NEW FILE
///
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


List<Posters> newsFromJson(str) => List<Posters>.from((str).map((x) => Posters.fromJson(x.data())));

String newsToJson(List<Posters> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Posters {
  Posters({
    required this.posterId,
    required this.posterDescription,
    required this.posterImage,
    required this.posterLink,
    required this.posterLinkExists,
    required this.posterDate,
    required this.status,
  });

  String posterId;
  String posterDescription;
  String posterImage;
  String posterLink;
  bool posterLinkExists;
  bool status;
  Timestamp posterDate;




  factory Posters.fromJson(Map<String, dynamic> json) => Posters(
    posterId: json["posterId"],
    posterDescription: json["posterDescription"],
    posterImage: json["posterImage"],
    posterLink: json["posterLink"],
    posterLinkExists: json["posterLinkExists"],
    posterDate: json["posterDate"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "posterId": posterId,
    "posterDescription": posterDescription,
    "posterImage": posterImage,
    "posterLink": posterLink,
    "posterLinkExists": posterLinkExists,
    "status": status,
    "posterDate": posterDate,
  };
}
