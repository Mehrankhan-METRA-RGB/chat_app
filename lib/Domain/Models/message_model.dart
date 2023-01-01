import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

class MessageModel {
  MessageModel({
    @required this.id,
    @required this.text,
    @required this.status,
    @required this.url,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final String? id;
  final String? text;
  final bool? status;
  final List<String>? url;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageModel copyWith({
    String? id,
    String? text,
    bool? status,
    List<String>? url,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      MessageModel(
        id: id ?? this.id,
        text: text ?? this.text,
        status: status ?? this.status,
        url: url ?? this.url,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory MessageModel.fromJson(String str) =>
      MessageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        text: json["text"],
        status: json["status"],
        url: json["url"] == null
            ? null
            : List<String>.from(json["url"].map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "text": text,
        "status": status,
        "url": url == null ? null : List<dynamic>.from(url!.map((x) => x)),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
