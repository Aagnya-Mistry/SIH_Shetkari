import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DiseasePrediction extends StatefulWidget {
  @override
  State<DiseasePrediction> createState() => _DiseasePredictionState();
}

class _DiseasePredictionState extends State<DiseasePrediction> {
  String? selectedCrop = 'Rice'; // Default to 'Rice'
  String? selectedIssue = 'Gallmidge'; // Default to 'Gallmidge'
  String? selectedYear = '2023'; // Default to '2023'
  String? selectedMonthInterval =
      '3 months onwards'; // Default to '3 months onwards'

  final List<String> crops = ['Rice', 'Cotton'];
  final Map<String, List<String>> cropIssues = {
    'Rice': ['Gallmidge', 'Greenleafhopper'],
    'Cotton': ['Americanbollworm', 'Pinkbollworm']
  };
  final List<String> years = ['2022', '2023', '2024'];
  final List<String> monthIntervals = [
    '3 months onwards',
    '6 months onwards',
    '9 months onwards'
  ];

  List<String> issuesForSelectedCrop = [];
  List<FlSpot> graphData = [];
  String inference = "Select crop and disease to see the inference.";

  @override
  void initState() {
    super.initState();
    issuesForSelectedCrop = cropIssues[selectedCrop!] ?? [];
    generateGraphData();
  }

  void generateGraphData() {
    if (selectedCrop != null &&
        selectedIssue != null &&
        selectedYear != null &&
        selectedMonthInterval != null) {
      setState(() {
        if (selectedCrop == 'Rice' &&
            selectedIssue == 'Gallmidge' &&
            selectedYear == '2023' &&
            selectedMonthInterval == '3 months onwards') {
          graphData = [
            FlSpot(20, 30),
            FlSpot(25, 50),
            FlSpot(30, 70),
            FlSpot(35, 90),
            FlSpot(40, 100),
          ];
          inference =
              "For Gallmidge in Rice, the pest population increases steadily as the temperature rises, peaking at 40°C. Farmers should take preventive action in warm conditions.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2024' &&
            selectedMonthInterval == '6 months onwards') {
          graphData = [
            FlSpot(20, 40),
            FlSpot(25, 60),
            FlSpot(30, 80),
            FlSpot(35, 100),
            FlSpot(40, 120),
          ];
          inference =
              "For Greenleafhopper in Rice, pest population growth is rapid after 30°C, indicating a significant threat at higher temperatures.";
        } else if (selectedCrop == 'Cotton' &&
            selectedIssue == 'Americanbollworm') {
          graphData = [
            FlSpot(20, 50),
            FlSpot(25, 70),
            FlSpot(30, 90),
            FlSpot(35, 110),
            FlSpot(40, 130),
          ];
          inference =
              "For Americanbollworm in Cotton, pest infestation intensifies beyond 30°C. Immediate measures are recommended in hot weather.";
        } else if (selectedCrop == 'Cotton' &&
            selectedIssue == 'Pinkbollworm') {
          graphData = [
            FlSpot(20, 60),
            FlSpot(25, 80),
            FlSpot(30, 100),
            FlSpot(35, 120),
            FlSpot(40, 140),
          ];
          inference =
              "For Pinkbollworm in Cotton, the pest population shows consistent growth with temperature, becoming severe above 35°C.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2023' &&
            selectedMonthInterval == '3 months onwards') {
          graphData = [
            FlSpot(20, 40),
            FlSpot(25, 60),
            FlSpot(30, 80),
            FlSpot(35, 100),
            FlSpot(40, 120),
          ];
          inference =
              "In 2023, for Greenleafhopper in Rice, pest population growth is rapid after 30°C, indicating a significant threat at higher temperatures. Farmers should prepare early for mitigation.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2023' &&
            selectedMonthInterval == '6 months onwards') {
          graphData = [
            FlSpot(20, 45),
            FlSpot(25, 65),
            FlSpot(30, 85),
            FlSpot(35, 105),
            FlSpot(40, 125),
          ];
          inference =
              "In 2023, for Greenleafhopper in Rice, pest population increases rapidly in mid-season. Timely action is crucial to prevent damage.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2023' &&
            selectedMonthInterval == '9 months onwards') {
          graphData = [
            FlSpot(20, 50),
            FlSpot(25, 70),
            FlSpot(30, 90),
            FlSpot(35, 110),
            FlSpot(40, 130),
          ];
          inference =
              "In 2023, for Greenleafhopper in Rice, late-season infestations are severe, especially at higher temperatures. Ensure long-term pest control measures.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2024' &&
            selectedMonthInterval == '3 months onwards') {
          graphData = [
            FlSpot(20, 35),
            FlSpot(25, 55),
            FlSpot(30, 75),
            FlSpot(35, 95),
            FlSpot(40, 115),
          ];
          inference =
              "In 2024, for Greenleafhopper in Rice, pest activity starts early in warm climates. Monitor fields closely in the initial months.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2024' &&
            selectedMonthInterval == '6 months onwards') {
          graphData = [
            FlSpot(20, 42),
            FlSpot(25, 62),
            FlSpot(30, 82),
            FlSpot(35, 102),
            FlSpot(40, 122),
          ];
          inference =
              "In 2024, for Greenleafhopper in Rice, pest population spikes mid-season, requiring preventive sprays and field management.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2024' &&
            selectedMonthInterval == '9 months onwards') {
          graphData = [
            FlSpot(20, 48),
            FlSpot(25, 68),
            FlSpot(30, 88),
            FlSpot(35, 108),
            FlSpot(40, 128),
          ];
          inference =
              "In 2024, for Greenleafhopper in Rice, pest infestation intensifies late in the year. Farmers should focus on long-term control strategies.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2025' &&
            selectedMonthInterval == '3 months onwards') {
          graphData = [
            FlSpot(20, 38),
            FlSpot(25, 58),
            FlSpot(30, 78),
            FlSpot(35, 98),
            FlSpot(40, 118),
          ];
          inference =
              "In 2025, for Greenleafhopper in Rice, pest activity starts early and correlates with rising temperatures. Early preventive action is advised.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2025' &&
            selectedMonthInterval == '6 months onwards') {
          graphData = [
            FlSpot(20, 44),
            FlSpot(25, 64),
            FlSpot(30, 84),
            FlSpot(35, 104),
            FlSpot(40, 124),
          ];
          inference =
              "In 2025, for Greenleafhopper in Rice, pest outbreaks occur mid-season. Farmers must apply timely pest control measures.";
        } else if (selectedCrop == 'Rice' &&
            selectedIssue == 'Greenleafhopper' &&
            selectedYear == '2025' &&
            selectedMonthInterval == '9 months onwards') {
          graphData = [
            FlSpot(20, 49),
            FlSpot(25, 69),
            FlSpot(30, 89),
            FlSpot(35, 109),
            FlSpot(40, 129),
          ];
          inference =
              "In 2025, for Greenleafhopper in Rice, late-season infestations are severe, especially at higher temperatures. Ensure effective pest management throughout the year.";
        } else {
          graphData = [];
          inference = "No data available for the selected combination.";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Disease Prediction",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Merriweather"),
        ),
        backgroundColor: Colors.grey.withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedCrop,
              isExpanded: true,
              hint: Text('Select Crop'),
              onChanged: (value) {
                setState(() {
                  selectedCrop = value;
                  issuesForSelectedCrop = cropIssues[value!] ?? [];
                  selectedIssue = issuesForSelectedCrop.isNotEmpty
                      ? issuesForSelectedCrop[0]
                      : null; // Default to first issue
                  generateGraphData();
                });
              },
              items: crops.map((crop) {
                return DropdownMenuItem(value: crop, child: Text(crop));
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedIssue,
              isExpanded: true,
              hint: Text('Select Disease'),
              onChanged: (value) {
                setState(() {
                  selectedIssue = value;
                  generateGraphData();
                });
              },
              items: issuesForSelectedCrop.map((issue) {
                return DropdownMenuItem(value: issue, child: Text(issue));
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedYear,
              isExpanded: true,
              hint: Text('Select Year'),
              onChanged: (value) {
                setState(() {
                  selectedYear = value;
                  generateGraphData();
                });
              },
              items: years.map((year) {
                return DropdownMenuItem(value: year, child: Text(year));
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedMonthInterval,
              isExpanded: true,
              hint: Text('Select Month Interval'),
              onChanged: (value) {
                setState(() {
                  selectedMonthInterval = value;
                  generateGraphData();
                });
              },
              items: monthIntervals.map((interval) {
                return DropdownMenuItem(value: interval, child: Text(interval));
              }).toList(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: graphData.isEmpty
                  ? Center(child: Text('Select values to generate the graph'))
                  : LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            axisNameSize: 30,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}',
                                  style: TextStyle(fontSize: 12),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            axisNameSize: 30,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}°C',
                                  style: TextStyle(fontSize: 12),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: graphData,
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 4,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(height: 16),
            Text(
              "Inference:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              inference,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
