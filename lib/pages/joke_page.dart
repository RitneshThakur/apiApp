import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  @override
  Widget build(BuildContext context) {
    Future fetchJoke() async {
      final response =
          await http.get(Uri.parse('https://v2.jokeapi.dev/joke/Any'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        return const Text("NO JOKES");
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: const Text("Joking"),
      ),
      body: FutureBuilder(
          future: fetchJoke(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final joke = snapshot.data;
              final setup = joke['setup'] ?? "Try Again";
              final delivery = joke['delivery']??"Try Again" ;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          height: MediaQuery.of(context).size.height / 8,
                          width: MediaQuery.of(context).size.width,
                          child: FlipCard(
                              front: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Center(
                                  child: Text(
                                    "$setup!",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              back: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Center(
                                  child: Text(
                                    '$delivery',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fetchJoke();
                        });
                      },
                      child: const Text('Another One'))
                ],
              );
            }
            return const Center(
              child: Text("NO Jokes Available"),
            );
          }),
    );
  }
}
