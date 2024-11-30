import 'package:flutter/material.dart';
import 'package:sih_shetkari/DiseaseInfoPage.dart';
import 'package:sih_shetkari/HomePage.dart';
import 'package:sih_shetkari/PreventionPage.dart';
import 'package:sih_shetkari/TrackerPage.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  final List<Map<String, String>> crops = [
    {'name': 'Apple'},
    {'name': 'Maize'},
    {'name': 'Pomegranate'},
    {'name': 'Banana'},
    {'name': 'Apple'},
    {'name': 'Maize'},
  ];

  int currentIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    Diseaseinfopage(),
    const Preventionpage(),
    const Trackerpage(),
    const Recommendations(),
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Center(
          child: Text(
            "Recommendations",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 80,
            //   color: Colors.grey.withOpacity(0.5),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //     IconButton(
            //         icon: Icon(Icons.arrow_back, color: Colors.black),
            //         onPressed: () => Navigator.pop(context),
            //     ),
            //     Center(
            //        child: Text(
            //        "Recommendations",
            //         style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //           fontFamily: "Merriweather"
            //         ),
            //        ),
            //      ),
            //     IconButton(
            //        icon: Icon(Icons.bookmark_border, color: Colors.black),
            //        onPressed: () {
            //        // Add bookmark functionality here
            //        },
            //     ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 20,),

            // Title Section
            const Text(
              "Suggestive Crops",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Mergeone"),
            ),
            const Divider(color: Colors.black),

            const SizedBox(height: 10),

            // Grid View for Crops
            Expanded(
              child: GridView.builder(
                itemCount: crops.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  final crop = crops[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 135,
                            height: 135,
                            color: const Color(0xFF2A9F5D),
                            //child: Image.asset(crop['image']!,fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        crop['name']!,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Mergeone"),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Description Text
            const Center(
              child: Text(
                "Also, find out about the quantity of fertilizer required:",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Mergeone"),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),

            // Calculate Fertilizer Button
            ElevatedButton(
              onPressed: () {
                // Add fertilizer calculation logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A9F5D),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Center(
                child: Text(
                  "Calculate Fertilizer",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Merriweather"),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bottom Navigation Buttons
            Align(alignment: Alignment.bottomCenter, child: _navBar())
          ],
        ),
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
