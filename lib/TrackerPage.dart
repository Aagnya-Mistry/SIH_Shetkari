import 'package:flutter/material.dart';

class Trackerpage extends StatefulWidget {
  const Trackerpage({super.key});

  @override
  State<Trackerpage> createState() => _TrackerpageState();
}

class _TrackerpageState extends State<Trackerpage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Calendar"),
    );
  }
}
