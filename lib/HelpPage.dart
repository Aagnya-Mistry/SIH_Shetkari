import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sih_shetkari/HomePage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Helppage extends StatefulWidget {
  @override
  State<Helppage> createState() => _HelppageState();
}

class _HelppageState extends State<Helppage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }
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
              title: Text(
                localizations.contact_us,
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
            Row(
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
                  localizations.icon_desp,
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
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.home, color: Color(0xFF2A9F5D)),
                    title: Text(localizations.page1), // Hardcoded title
                  ),
                  ListTile(
                    leading: Icon(Icons.agriculture, color: Color(0xFF2A9F5D)),
                    title: Text(localizations.page2), // Hardcoded title
                  ),
                  ListTile(
                    leading: Icon(Icons.medical_information,
                        color: Color(0xFF2A9F5D)),
                    title: Text(localizations.page3), // Hardcoded title
                  ),
                  ListTile(
                    leading: Icon(Icons.mic, color: Color(0xFF2A9F5D)),
                    title: Text(localizations.page4), // Hardcoded title
                  ),
                  ListTile(
                    leading: Icon(Icons.recommend, color: Color(0xFF2A9F5D)),
                    title: Text(localizations.page5), // Hardcoded title
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
