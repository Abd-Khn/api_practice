import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "APIs Practice",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          // var name = user['name']['title']['last'];
          var title = user['name']['title'];
          // var firstName = user['name']['first'];
          var lastName = user['name']['last'];
          var name = '$title $lastName';
          var email = user['email'];
          var imageUrl = user['picture']['thumbnail'];
          return ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(imageUrl)),
            title: Text(
              name.toString(),
            ),
            subtitle: Text(email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.refresh),
      ),
    );
  }

  void fetchUsers() async {
    print("Fetch Users Called");
    var url = "https://randomuser.me/api/?results=100";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var body = response.body;
    var json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print("Fetch Users Completed");
  }
}
