import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sih_shetkari/HomePage.dart';

class Helppage extends StatefulWidget {
  @override
  State<Helppage> createState() => _HelppageState();
}

class _HelppageState extends State<Helppage> {
  final List<Map<IconData, String>> desp = [
    {Icons.home: "Home Page"},
    {Icons.agriculture: "Disease Information Page"},
    {Icons.medical_information: "Preventive Measures"},
    {Icons.calendar_month: "Daily Tracker"},
    {Icons.recommend: "Recommendations"},
  ];

  // const Helppage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Text(
          'Help',
          style: TextStyle(
              fontFamily: "Merriweather",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text(
                'Contact Us',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Mergeone"),
              ),
              subtitle: const Text(
                '+91-987654321 | www.shetkari.com',
                style: TextStyle(fontSize: 15, fontFamily: "Mergeone"),
              ),
              onTap: () {
                // Handle contact us action
              },
            ),
            const Divider(),
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.import_contacts_sharp,
                  color: Color(0xFF2A9F5D),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Icon Description : ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Mergeone"),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: desp.length,
                itemBuilder: (context, index) {
                  final iconData = desp[index].keys.first;
                  final description =
                      desp[index].values.first; // Fixed this line
                  return ListTile(
                    leading: Icon(iconData, color: Colors.green),
                    title: Text(description),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
