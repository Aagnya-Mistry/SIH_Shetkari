import 'package:flutter/material.dart';
import 'package:sih_shetkari/DiseaseInfoPage.dart';
import 'package:sih_shetkari/GovtSchemas.dart';
import 'package:sih_shetkari/HomePage.dart';
import 'package:sih_shetkari/FarmDetailsPage.dart';
import 'package:sih_shetkari/VoiceAssitant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Preventionpage extends StatefulWidget {
  const Preventionpage({super.key});

  @override
  State<Preventionpage> createState() => _PreventionpageState();
}

class _PreventionpageState extends State<Preventionpage> {
  String? selectedCrop;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return Text('Localization not available'); // Fallback text
    }

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
            localizations.page_5,
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
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedCrop,
            hint: Text(localizations.selection),
            items: [
              DropdownMenuItem(
                  value: 'apple', child: Text(localizations.apple)),
              DropdownMenuItem(
                  value: 'tomato', child: Text(localizations.tomato)),
              DropdownMenuItem(value: 'rice', child: Text(localizations.rice)),
              DropdownMenuItem(
                  value: 'cotton',
                  child: Text(
                    localizations.cotton,
                  )),
              DropdownMenuItem(
                  value: 'cauliflower', child: Text(localizations.cauliflower)),
              DropdownMenuItem(
                  value: 'maize', child: Text(localizations.maize)),
              DropdownMenuItem(
                  value: 'soybean', child: Text(localizations.soyabean)),
              DropdownMenuItem(
                  value: 'spinach', child: Text(localizations.spinach)),
              DropdownMenuItem(
                  value: 'sugarcane', child: Text(localizations.sugarcane)),
              DropdownMenuItem(
                  value: 'pomegranate', child: Text(localizations.pomegranate)),
            ],
            onChanged: (value) {
              setState(() {
                selectedCrop = value;
              });
            },
          ),
          Expanded(
            child: selectedCrop != null
                ? ListView(
                    children: _getDiseaseList(selectedCrop!),
                  )
                : Center(
                    child: Text(localizations.deafult_page_5),
                  ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  List<Widget> _getDiseaseList(String selectedCrop) {
    if (selectedCrop == 'apple') {
      return [
        _buildDiseaseTile(AppLocalizations.of(context)!.apple_scab,
            AppLocalizations.of(context)!.apple_scab_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.apple_black_rot,
            AppLocalizations.of(context)!.apple_black_rot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.apple_cedar_apple_rust,
            AppLocalizations.of(context)!.apple_cedar_apple_rust_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.apple_healthy,
            AppLocalizations.of(context)!.apple_healthy_preventive),
      ];
    } else if (selectedCrop == 'rice') {
      return [
        _buildDiseaseTile(AppLocalizations.of(context)!.rice_tungro,
            AppLocalizations.of(context)!.rice_tungro_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.rice_blast,
            AppLocalizations.of(context)!.rice_blast_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.rice_brownspot,
            AppLocalizations.of(context)!.rice_brownspot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.rice_bacterial_blight,
            AppLocalizations.of(context)!.rice_bacterial_blight_preventive),
      ];
    } else if (selectedCrop == 'sugarcane') {
      return [
        _buildDiseaseTile(AppLocalizations.of(context)!.sugarcane_yellow_rust,
            AppLocalizations.of(context)!.sugarcane_yellow_rust_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.sugarcane_red_rot,
            AppLocalizations.of(context)!.sugarcane_red_rot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.sugarcane_red_rust,
            AppLocalizations.of(context)!.sugarcane_red_rust_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.sugarcane_mosaic,
            AppLocalizations.of(context)!.sugarcane_mosaic_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.sugarcane_healthy,
            AppLocalizations.of(context)!.sugarcane_healthy_preventive),
      ];
    } else if (selectedCrop == 'tomato') {
      return [
        _buildDiseaseTile(AppLocalizations.of(context)!.tomato_bacterial_spot,
            AppLocalizations.of(context)!.tomato_bacterial_spot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.tomato_early_blight,
            AppLocalizations.of(context)!.tomato_early_blight_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.tomato_late_blight,
            AppLocalizations.of(context)!.tomato_late_blight_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.tomato_leaf_mold,
            AppLocalizations.of(context)!.tomato_leaf_mold_preventive),
        _buildDiseaseTile(
            AppLocalizations.of(context)!.tomato_septoria_leaf_spot,
            AppLocalizations.of(context)!.tomato_septoria_leaf_spot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.tomato_spider_mites,
            AppLocalizations.of(context)!.tomato_spider_mites_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.tomato_target_spot,
            AppLocalizations.of(context)!.tomato_target_spot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.tomato_ytlcv,
            AppLocalizations.of(context)!.tomato_ytlcv_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.tomato_healthy,
            AppLocalizations.of(context)!.tomato_healthy_preventive),
      ];
    } else if (selectedCrop == 'cotton') {
      return [
        _buildDiseaseTile(AppLocalizations.of(context)!.cotton_bacterial_blight,
            AppLocalizations.of(context)!.cotton_bacterial_blight_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.cotton_aphid,
            AppLocalizations.of(context)!.cotton_aphid_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.cotton_whitefly,
            AppLocalizations.of(context)!.cotton_whitefly_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.cotton_anthracnose,
            AppLocalizations.of(context)!.cotton_anthracnose_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.cotton_healthy,
            AppLocalizations.of(context)!.cotton_healthy_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.cotton_red_cotton_bug,
            AppLocalizations.of(context)!.cotton_red_cotton_bug_preventive),
      ];
    } else if (selectedCrop == 'cauliflower') {
      return [
        _buildDiseaseTile(
            AppLocalizations.of(context)!.cauliflower_downy_mildew,
            AppLocalizations.of(context)!.cauliflower_downy_mildew_preventive),
        _buildDiseaseTile(
            AppLocalizations.of(context)!.cauliflower_bacterial_spot_rot,
            AppLocalizations.of(context)!
                .cauliflower_bacterial_spot_rot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.cauliflower_black_rot,
            AppLocalizations.of(context)!.cauliflower_black_rot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.cauliflower_healthy,
            AppLocalizations.of(context)!.cauliflower_healthy_preventive),
      ];
    } else if (selectedCrop == 'soybean') {
      return [
        _buildDiseaseTile(AppLocalizations.of(context)!.soybean_healthy,
            AppLocalizations.of(context)!.soybean_healthy_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.soybean_caterpillar,
            AppLocalizations.of(context)!.soybean_caterpillar_preventive),
        _buildDiseaseTile(
            AppLocalizations.of(context)!.soybean_diabrotica_speciosa,
            AppLocalizations.of(context)!
                .soybean_diabrotica_speciosa_preventive),
      ];
    } else if (selectedCrop == 'spinach') {
      return [
        _buildDiseaseTile(AppLocalizations.of(context)!.spinach_healthy,
            AppLocalizations.of(context)!.spinach_healthy_preventive),
        _buildDiseaseTile(
            AppLocalizations.of(context)!.spinach_anthracnose_leaf_spot,
            AppLocalizations.of(context)!
                .spinach_anthracnose_leaf_spot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.spinach_straw_mite,
            AppLocalizations.of(context)!.spinach_straw_mite_preventive),
      ];
    } else if (selectedCrop == 'pomegranate') {
      return [
        _buildDiseaseTile(AppLocalizations.of(context)!.pomegranate_alternaria,
            AppLocalizations.of(context)!.pomegranate_alternaria_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.pomegranate_anthracnose,
            AppLocalizations.of(context)!.pomegranate_anthracnose_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.pomegranate_cercospora,
            AppLocalizations.of(context)!.pomegranate_cercospora_preventive),
        _buildDiseaseTile(
            AppLocalizations.of(context)!.pomegranate_bacterial_blight,
            AppLocalizations.of(context)!
                .pomegranate_bacterial_blight_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.pomegranate_healthy,
            AppLocalizations.of(context)!.pomegranate_healthy_preventive),
      ];
    } else if (selectedCrop == 'maize') {
      return [
        _buildDiseaseTile(
            AppLocalizations.of(context)!.maize_cercospora_leaf_spot,
            AppLocalizations.of(context)!
                .maize_cercospora_leaf_spot_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.maize_common_rust,
            AppLocalizations.of(context)!.maize_common_rust_preventive),
        _buildDiseaseTile(
            AppLocalizations.of(context)!.maize_northern_leaf_blight,
            AppLocalizations.of(context)!
                .maize_northern_leaf_blight_preventive),
        _buildDiseaseTile(AppLocalizations.of(context)!.maize_healthy,
            AppLocalizations.of(context)!.maize_healthy_preventive),
      ];
    } else {
      return [Text('No data available for this crop.')];
    }
  }

  Widget _buildDiseaseTile(String diseaseName, String preventionMethods) {
    return Container(
      decoration: const BoxDecoration(
          //gradient: LinearGradient(colors: [Colors.white, Color(0xFF2A9F5D)],begin: Alignment.centerLeft),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey.shade700,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.black12, width: 2)),
        margin: const EdgeInsets.all(5.0),
        child: ListTile(
          title: Text(
            diseaseName,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Mergeone",
                color: Color(0xFF2A9F5D)),
          ),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(preventionMethods),
          ]),
        ),
      ),
    );
  }
}
