// To parse this JSON data, do
//
//     final ticketInfoModel = ticketInfoModelFromJson(jsonString);

import 'dart:convert';

TicketInfoModel ticketInfoModelFromJson(String str) =>
    TicketInfoModel.fromJson(json.decode(str));

String ticketInfoModelToJson(TicketInfoModel data) =>
    json.encode(data.toJson());

class TicketInfoModel {
  TicketInfoModel({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  int status;
  bool success;
  String message;
  List<Datum> data;

  factory TicketInfoModel.fromJson(Map<String, dynamic> json) =>
      TicketInfoModel(
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
    required this.route,
    required this.departureTime,
    required this.arrivalTime,
    required this.tourType,
    required this.daysOfWeek,
  });

  String route;
  String departureTime;
  String arrivalTime;
  String tourType;
  List<String> daysOfWeek;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        route: json["route"],
        departureTime: json["departureTime"],
        arrivalTime: json["arrivalTime"],
        tourType: json["tourType"],
        daysOfWeek: List<String>.from(json["daysOfWeek"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "route": route,
        "departureTime": departureTime,
        "arrivalTime": arrivalTime,
        "tourType": tourType,
        "daysOfWeek": List<dynamic>.from(daysOfWeek.map((x) => x)),
      };
}
