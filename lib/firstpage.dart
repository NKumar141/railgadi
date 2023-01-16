import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final myController1 = TextEditingController();

  var headers = {
    'X-RapidAPI-Key': '07fd6aece4mshabbc768a80b7e62p1a3d6ajsnb926be3fadd6',
    'X-RapidAPI-Host': 'pnr-status-indian-railway.p.rapidapi.com'
  };
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://pnr-status-indian-railway.p.rapidapi.com/pnr-check/2734377912'));

  Map railresponse = {};
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

  String sresponse = " ";
  Map mapresponse = {};
  Map dataresponse = {};
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users/2"));
    if (response.statusCode == 200) {
      setState(() {
        sresponse = response.body;
        mapresponse = json.decode(sresponse);
        dataresponse = mapresponse['data'];
      });
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
        title: const Text('Retrieve Text Input'),
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
                  ? Text("load the data")
                  //: Text(mapresponse['data'].toString()),
                  : Column(
                      children: [
                        Text(railresponse['data']['boardingInfo']['stationName']
                                .toString() +
                            ' Platform - ' +
                            railresponse['data']['boardingInfo']['platform']
                                .toString()),
                        Text(railresponse['data']['boardingInfo']
                                ['departureTime']
                            .toString()),
                        Text(railresponse['data']['destinationInfo']
                                    ['stationName']
                                .toString() +
                            ' Platform - ' +
                            railresponse['data']['destinationInfo']['platform']
                                .toString()),
                        Text(railresponse['data']['destinationInfo']
                                ['arrivalTime']
                            .toString()),
                        Text('Coach - ' +
                            railresponse['data']['seatInfo']['coach']
                                .toString()),
                        Text('Berth - ' +
                            railresponse['data']['seatInfo']['berth']
                                .toString()),
                        Text('TrainNo - ' +
                            railresponse['data']['trainInfo']['trainNo']
                                .toString()),
                        Text(railresponse['data']['trainInfo']['name']
                            .toString()),
                        Text(
                            railresponse['data']['trainInfo']['dt'].toString()),
                      ],
                    ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                apicall();
                railapicall();
              },
              icon: const Icon(
                Icons.adjust_outlined,
                size: 24.0,
              ),
              label: Text('dabao'),
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
                apicall();
                railapicall();
              },
              icon: const Icon(
                Icons.adjust_outlined,
                size: 24.0,
              ),
              label: Text(' JOR SE dabao'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(myController1.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}
