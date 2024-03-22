import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var client = http.Client();

  LoadData() async {
    String url = 'https://randomuser.me/api/?results=5';
    Uri uri = Uri.parse(url);
    // Map<String, String> header = {"id": ""};
    // Map<String, dynamic> body = {"id": ""};
    Response response = await client.get(uri);

    if (response.statusCode == 200) {
      print("");
    } else if (response.statusCode == 404) {
      print("Sorry Not Found");
    }

    print("responses ${response.statusCode}");
    print("responses ${response.body}");
  }

  @override
  void initState() {
    super.initState();
    LoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APIs Practice"),
      ),
      body: Container(
        child: Text(
          "Data",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
