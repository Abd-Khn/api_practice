import 'dart:convert';

import 'package:api_practice/model/user.dart';
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
  List<User> users = [];
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
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          var email = user.email;
          // var color = user.gender == 'male' ? Colors.blue : Colors.pink;
          return ListTile(
            title: Text("${user.name.title} ${user.name.last}"),
            subtitle: Text(user.email),

            // tileColor: color,
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: 200, // Adjust the width as needed
          height: 50, // Adjust the height as needed
          child: ElevatedButton(
            onPressed: fetchUsers,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
              padding:
                  EdgeInsets.all(15), // Increase padding for a bigger button
            ),
            child: Text(
              "Refresh list",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void fetchUsers() async {
    print("Fetch Users Called");
    var url = "https://randomuser.me/api/?results=100";
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    var body = response.body;
    var json = jsonDecode(body);

    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      return User(
        cell: e['cell'],
        email: e['email'],
        gender: e['gender'],
        phone: e['phone'],
        nat: e['nat'],
        name: name,
      );
    }).toList();
    setState(() {
      users = transformed;
    });
    print("Fetch Users Completed");
  }
}
