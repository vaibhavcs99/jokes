// To parse this JSON data, do
//
//     final jokesModel = jokesModelFromJson(jsonString);

import 'dart:convert';

import 'package:jokes/features/jokes/domain/entities/jokes_entities.dart';

List<JokesModel> jokesModelFromJson(String str) =>
    List<JokesModel>.from(json.decode(str).map((x) => JokesModel.fromJson(x)));

String jokesModelToJson(List<JokesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JokesModel extends Jokes{
  JokesModel({
    this.id,
    this.type,
    this.setup,
    this.punchline,
  });

  int id;
  String type;
  String setup;
  String punchline;

  factory JokesModel.fromJson(Map<String, dynamic> json) => JokesModel(
        id: json["id"],
        type: json["type"],
        setup: json["setup"],
        punchline: json["punchline"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "setup": setup,
        "punchline": punchline,
      };

  // @override
  // String toString() {
  //   return 'JokesModel(id: $id, type: $type, setup: $setup, punchline: $punchline)';
  // }
}

