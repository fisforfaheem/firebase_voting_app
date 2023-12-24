import 'package:firebase_voting_app_example/model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: MockBandInfo.bandList.length,
          itemExtent: 50,
          itemBuilder: (context, index) => BandListInterface(index: index),
        ),
      ),
    );
  }
}

class BandListInterface extends StatelessWidget {
  final int index;
  const BandListInterface({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // return const Text('dasdad');
    return ListTile(
      leading: Text(MockBandInfo.bandList[index].name),
      trailing: Text(MockBandInfo.bandList[index].votes.toString()),
    );
  }
}
