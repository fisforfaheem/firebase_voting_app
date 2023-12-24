import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_voting_app_example/model.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Simple Voting App Using Firebase!')),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('candidates').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading spinner when data is loading
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemExtent: 50,
                itemBuilder: (context, index) {
                  final doc = snapshot.data?.docs[index];
                  final data =
                      MockBandInfo.fromMap(doc?.data() as Map<String, dynamic>);

                  return ListTile(
                    title: Text(data.name),
                    trailing: Text(data.votes.toString()),
                    onTap: () {
                      // Increment votes
                      FirebaseFirestore.instance
                          .collection('candidates')
                          .doc(doc?.id)
                          .update({'votes': FieldValue.increment(1)});
                    },
                  );
                },
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}
