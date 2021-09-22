import 'package:flutter/material.dart';
import 'package:flutter_case_study_project/Models/ticketCards_model.dart';
import 'package:flutter_case_study_project/Models/ticketInfo_model.dart';

class DepartureDatas extends StatelessWidget {
  final TicketInfoModel? datas;

  DepartureDatas({required this.datas});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TicketCards(
          route: datas!.data[0].route,
          arrivalTime: datas!.data[0].arrivalTime,
          departureTime: datas!.data[0].departureTime,
          daysOfWeek: datas!.data[0].daysOfWeek,
          tourType: datas!.data[0].tourType,
        ),
        SizedBox(
          height: 16,
          child: Divider(
            height: 0,
            thickness: 1,
            endIndent: 15,
            indent: 15,
            color: Color(0xffD1D1D1),
          ),
        ),
        TicketCards(
          route: datas!.data[1].route,
          arrivalTime: datas!.data[1].arrivalTime,
          departureTime: datas!.data[1].departureTime,
          daysOfWeek: datas!.data[1].daysOfWeek,
          tourType: datas!.data[1].tourType,
        ),
        SizedBox(
          height: 16,
          child: Divider(
            height: 0,
            thickness: 1,
            endIndent: 15,
            indent: 15,
            color: Color(0xffD1D1D1),
          ),
        ),
        TicketCards(
          route: datas!.data[2].route,
          arrivalTime: datas!.data[2].arrivalTime,
          departureTime: datas!.data[2].departureTime,
          daysOfWeek: datas!.data[2].daysOfWeek,
          tourType: datas!.data[2].tourType,
        ),
        SizedBox(
          height: 16,
          child: Divider(
            height: 0,
            thickness: 1,
            endIndent: 15,
            indent: 15,
            color: Color(0xffD1D1D1),
          ),
        ),
        TicketCards(
          route: datas!.data[3].route,
          arrivalTime: datas!.data[3].arrivalTime,
          departureTime: datas!.data[3].departureTime,
          daysOfWeek: datas!.data[3].daysOfWeek,
          tourType: datas!.data[3].tourType,
        ),
      ],
    );
  }
}
