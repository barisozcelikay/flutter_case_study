import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_case_study_project/constansts.dart';

class TicketCards extends StatelessWidget {
  const TicketCards({
    Key? key,
    required this.route,
    required this.departureTime,
    required this.arrivalTime,
    required this.tourType,
    required this.daysOfWeek,
  }) : super(key: key);
  final String route;
  final String departureTime;
  final String arrivalTime;
  final String tourType;
  final List daysOfWeek;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        minLeadingWidth: 10,
        leading: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            tourType == "Night" ? Icons.bedtime : Icons.wb_sunny,
            color: kselected_color,
          )
        ]),
        title: Text(
          '${route} / ${departureTime}-${arrivalTime}',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${daysOfWeek.join(' - ')}',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
