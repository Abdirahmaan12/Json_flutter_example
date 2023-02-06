import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json/photos.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Photos> photos = [];

  Future<List<Photos>> getPhotos() async {
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      for (var element in data) {
        photos.add(Photos.fromJson(element));
      }
    }

    return photos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('load photos'))),
      body: FutureBuilder<List<Photos>>(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Photos> data = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  leading: Container(
                    child: Image.network(data[index].thumnailUrl ?? ""),
                  ),
                  title: Text(data[index].title ?? ""),
                  trailing: Text(data[index].id.toString()),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
