import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PickUpLine extends StatefulWidget {
  const PickUpLine({super.key});

  @override
  State<PickUpLine> createState() => _PickUpLineState();
}

class _PickUpLineState extends State<PickUpLine> {
  @override
  Widget build(BuildContext context) {
    Future fetchPickUpLine() async {
      final response =
          await http.get(Uri.parse('https://rizzapi.vercel.app/random'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        return const Text("NO Lines");
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: const Text("PICKUP LINES"),
      ),
      body: FutureBuilder(
          future: fetchPickUpLine(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final line = snapshot.data;
              final lines = line['text'];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all( 8.0),
                    child: Material(
                      elevation: 10,
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "$lines",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fetchPickUpLine();
                        });
                      },
                      child: const Text("Another one"))
                ],
              );
            }
            return const Text("NO Lines available");
          }),
    );
  }
}
