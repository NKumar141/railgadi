import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:railgadi/entry.dart';
import 'dart:convert';
import 'config.dart';
import 'functions.dart';
import 'payload.dart';

Map railresponse = cons;

class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Page',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final myController1 = TextEditingController();

  var request;
  // = http.Request('GET',
  //     Uri.parse('https://pnr-status-indian-railway.p.rapidapi.com/pnr-check/'));

  String railres = "";
  Future railapicall() async {
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    railres = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      setState(() {
        railresponse = json.decode(railres);
      });

      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rail Gadi'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            const SizedBox(height: 65),
            const Text(
              'Welcome to RailGadi',
              style: TextStyle(color: Colors.red, fontSize: 30),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: myController1,
                decoration: InputDecoration(
                  hintText: 'Enter Your PNR',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff679633))),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: railresponse['data'] == null
                  ? Text("Enter PNR number pls")
                  //: Text(mapresponse['data'].toString()),
                  : InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => payload()));
                      },
                      child: entrywid(),
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  request = http.Request(
                      'GET',
                      Uri.parse(
                          'https://pnr-status-indian-railway.p.rapidapi.com/pnr-check/' +
                              myController1.text));
                });

                railapicall();
              },
              icon: const Icon(
                Icons.adjust_outlined,
                size: 24.0,
              ),
              label: Text(' Get Details ! '),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
