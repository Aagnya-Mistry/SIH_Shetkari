import 'package:flutter/material.dart';
import 'package:sih_shetkari/DiseaseInfoPage.dart';
import 'package:sih_shetkari/HomePage.dart';
import 'package:sih_shetkari/Recommendations.dart';
import 'package:sih_shetkari/TrackerPage.dart';

class Preventionpage extends StatefulWidget {
  const Preventionpage({super.key});

  @override
  State<Preventionpage> createState() => _PreventionpageState();
}

class _PreventionpageState extends State<Preventionpage> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    Diseaseinfopage(),
    const Preventionpage(),
    const Trackerpage(),
    const Recommendations()
  ];
  final List<IconData> icons = [
    Icons.home,
    Icons.agriculture,
    Icons.medical_information,
    Icons.calendar_month,
    Icons.recommend
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        //elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage())),
        ),
        title: const Center(
          child: Text(
            "Preventive Measures",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Merriweather"),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {
              // Add bookmark functionality here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "To cure the disease, try these procedures:",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Mergeone"),
                ),
                SizedBox(height: 5),
                // Procedures List
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: BulletedList(items: [
                    "ksjdfg",
                    "skfgwkaef",
                    "skdjfb",
                    "ksdjbfvalsd",
                    "sjdfbs,nd",
                    "s dvksadjgnfv",
                  ]),
                ),
                SizedBox(height: 20),
                Text(
                  "Recommended Insecticides:",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Mergeone"),
                ),
                SizedBox(height: 5),
                // Insecticides List
                Padding(
                  padding: EdgeInsets.only(right: 125, left: 10),
                  child: BulletedList(
                    items: [
                      "Actara",
                      "Lannate",
                      "Malathion",
                      "Nuvan",
                      "Politrin-C",
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 65, right: 10),
              child: Image.asset(
                'assets/images/fertilizer.png', // Replace with your image path
                width: 125,
                height: 125,
              ),
            ),
          ),
          // Bottom Navigation Buttons
          Align(alignment: Alignment.bottomCenter, child: _navBar())
        ],
      ),
    );
  }

  Widget _navBar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(
          color: const Color(0xFF2A9F5D),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF1D4031), width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: icons.map((e) {
          int index = icons.indexOf(e);
          bool isSelected = currentIndex == index;
          return Material(
              color: Colors.transparent,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => pages[index]));
                    });
                  },
                  child: Icon(
                    e,
                    color: isSelected ? Colors.black54 : Colors.white,
                    size: 35,
                  )));
        }).toList(),
      ),
    );
  }
}

class BulletedList extends StatelessWidget {
  final List<String> items;

  const BulletedList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
