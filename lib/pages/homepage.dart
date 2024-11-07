import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:icons_plus/icons_plus.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> text = [
      "Jokes",
      "Pick Up Lines",
      "Quotes",
      "Poetry",
    ];
    final List<IconData> icons = [
      LineAwesome.laugh,
      Iconsax.lovely_bold,
      Iconsax.quote_down_square_bold,
      Icons.book
    ];
    final List<VoidCallback> onPressedFunctions = [
          () => Navigator.pushNamed(context, '/joke-page'),
          () => Navigator.pushNamed(context, '/pickup-page'),
          () => Navigator.pushNamed(context, '/quotes-page'),
          () => Navigator.pushNamed(context, '/poetry-page'),
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        centerTitle: true,

        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ALL IN ONE",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              "By: Ritnesh Thakur",
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 4.0, // Adds a shadow for a clean effect
        toolbarHeight: 70, // Adjust height to make it more prominent
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: onPressedFunctions[index],
                    child: AnimatedGradientBorder(
                      gradientColors: [
                        Colors.indigoAccent,
                        Colors.blueAccent,
                        Colors.indigo
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      glowSize: 2,
                      borderSize: 2,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius:
                            BorderRadius.circular(15), // Rounded corners
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  icons[index],
                        
                                  color: Colors.black,
                                  size: 50.0, // Icon size
                                ),
                                Text(text[index])
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}