import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  @override
  Widget build(BuildContext context) {
    Future fetchQuote() async {
      final response =
          await http.get(Uri.parse('https://zenquotes.io/api/random'));
      if (response.statusCode == 200) {
        final List<dynamic> data =
            json.decode(response.body); // Parse as a list
        return data[0]; // Return the first element of the list
      } else {
        throw Exception("Failed to load quote");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes"),
      ),
      body: FutureBuilder(
          future: fetchQuote(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final res = snapshot.data!;
              final quote = res['q'] as String;
              final author = res['a'] as String;
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '"$quote"',
                      style: const TextStyle(
                          fontSize: 23, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '- $author',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        fetchQuote();
                      });
                    }, child: Text("Another One"))
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("Failed to load quote"));
            } else {
              return const Center(child: Text("No data"));
            }
          }),
    );
  }
}
