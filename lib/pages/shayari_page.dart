import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PoetryPage extends StatefulWidget {
  const PoetryPage({super.key});

  @override
  State<PoetryPage> createState() => _PoetryPageState();
}

class _PoetryPageState extends State<PoetryPage> {
  // Function to fetch poetry
  Future<Map<String, dynamic>> fetchPoetry() async {
    final response = await http.get(Uri.parse('https://poetrydb.org/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data[0];
    } else {
      throw Exception('No Poetry Available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poetry'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchPoetry(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final poetry = snapshot.data!;
            final List<dynamic> lines = poetry['lines'];
            final String title = poetry['title'];
            final String author = poetry['author'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'By $author',
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: lines.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            child: Text(
                              lines[index],
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        fetchPoetry();
                      });
                    }, child: Text("Another One")),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Failed to load poetry"));
          } else {
            return const Center(child: Text("No poetry available"));
          }
        },
      ),
    );
  }
}
