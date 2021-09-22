// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  int status;
  bool success;
  String message;
  List<Datum> data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.email,
    required this.userId,
  });

  String email;
  String userId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        email: json["email"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "userId": userId,
      };
}
