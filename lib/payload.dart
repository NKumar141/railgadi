import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:railgadi/entry.dart';
import 'dart:convert';
import 'config.dart';
import 'functions.dart';

class payload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payload Page',
      home: payloadpage(),
    );
  }
}

class payloadpage extends StatefulWidget {
  const payloadpage({super.key});
  @override
  State<payloadpage> createState() => payloadState();
}

class payloadState extends State<payloadpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rail Gadi'),
      ),
      body: Center(
          child: ListView(
        children: [
          entrywid(),
        ],
      )),
    );
  }
}
