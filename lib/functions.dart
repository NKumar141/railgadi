import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firstpage.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void notifi() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings);
  bool? initialized =
      await notificationsPlugin.initialize(initializationSettings);

  showNotification();
  //log("notifications : $initialized");
}

void showNotification() {
  AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    "channelId",
    "channelName",
    icon: "@mipmap/ic_launcher",
    priority: Priority.max,
    importance: Importance.max,
  );
  NotificationDetails notiDetails =
      NotificationDetails(android: androidDetails);

  notificationsPlugin.show(
      0,
      railresponse['data'] == null
          ? "Enter PNR number pls"
          : railresponse['data']['trainInfo']['trainNo'].toString() +
              "  " +
              railresponse['data']['trainInfo']['name'].toString(),
      railresponse['data'] == null
          ? "Enter PNR number pls"
          : railresponse['data']['seatInfo']['coach'].toString() +
              "  " +
              railresponse['data']['seatInfo']['berth'].toString() +
              "   " +
              railresponse['data']['boardingInfo']['stationName'].toString() +
              "  " +
              railresponse['data']['boardingInfo']['departureTime'].toString(),
      notiDetails);
}
