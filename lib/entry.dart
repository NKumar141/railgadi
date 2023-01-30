import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firstpage.dart';

Widget entrywid() {
  return Column(
    children: [
      Text(railresponse['data']['boardingInfo']['stationName'].toString() +
          ' Platform - ' +
          railresponse['data']['boardingInfo']['platform'].toString()),
      Text(railresponse['data']['boardingInfo']['departureTime'].toString()),
      Text(railresponse['data']['destinationInfo']['stationName'].toString() +
          ' Platform - ' +
          railresponse['data']['destinationInfo']['platform'].toString()),
      Text(railresponse['data']['destinationInfo']['arrivalTime'].toString()),
      Text('Coach - ' + railresponse['data']['seatInfo']['coach'].toString()),
      Text('Berth - ' + railresponse['data']['seatInfo']['berth'].toString()),
      Text('TrainNo - ' +
          railresponse['data']['trainInfo']['trainNo'].toString()),
      Text(railresponse['data']['trainInfo']['name'].toString()),
      Text(railresponse['data']['trainInfo']['dt'].toString()),
    ],
  );
}
