import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sih_shetkari/HomePage.dart';

class GovtschemasPage extends StatefulWidget {
  const GovtschemasPage({super.key});

  @override
  State<GovtschemasPage> createState() => _GovtschemasPageState();
}

class _GovtschemasPageState extends State<GovtschemasPage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }

    // Yojana data keys
    List<Map<String, String>> yojanas = [
      {
        'name': AppLocalizations.of(context)!.yojna_no_1_name,
        'desc': AppLocalizations.of(context)!.yojna_no_1_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_2_name,
        'desc': AppLocalizations.of(context)!.yojna_no_2_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_3_name,
        'desc': AppLocalizations.of(context)!.yojna_no_3_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_4_name,
        'desc': AppLocalizations.of(context)!.yojna_no_4_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_5_name,
        'desc': AppLocalizations.of(context)!.yojna_no_5_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_6_name,
        'desc': AppLocalizations.of(context)!.yojna_no_6_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_7_name,
        'desc': AppLocalizations.of(context)!.yojna_no_7_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_8_name,
        'desc': AppLocalizations.of(context)!.yojna_no_8_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_9_name,
        'desc': AppLocalizations.of(context)!.yojna_no_9_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_10_name,
        'desc': AppLocalizations.of(context)!.yojna_no_10_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_11_name,
        'desc': AppLocalizations.of(context)!.yojna_no_11_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_12_name,
        'desc': AppLocalizations.of(context)!.yojna_no_12_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_13_name,
        'desc': AppLocalizations.of(context)!.yojna_no_13_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_14_name,
        'desc': AppLocalizations.of(context)!.yojna_no_14_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_15_name,
        'desc': AppLocalizations.of(context)!.yojna_no_15_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_16_name,
        'desc': AppLocalizations.of(context)!.yojna_no_16_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_17_name,
        'desc': AppLocalizations.of(context)!.yojna_no_17_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_18_name,
        'desc': AppLocalizations.of(context)!.yojna_no_18_desc,
      },
      {
        'name': AppLocalizations.of(context)!.yojna_no_19_name,
        'desc': AppLocalizations.of(context)!.yojna_no_19_desc,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        //elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage())),
        ),
        title: Center(
          child: Text(
            localizations.page_6,
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
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: yojanas.length,
        itemBuilder: (context, index) {
          String yojanaName = yojanas[index]['name']!;
          String yojanaDesc = yojanas[index]['desc']!;
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    yojanaName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    yojanaDesc,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
