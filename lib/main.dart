// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package for database operations
import 'package:firebase_core/firebase_core.dart'; // Firebase core package for initializing Firebase
import 'package:firebase_voting_app_example/model.dart'; // Importing the model class
import 'package:flutter/material.dart'; // Flutter material package for UI components

import 'firebase_options.dart'; // Importing Firebase options

// Main function where the app starts
void main() async {
  // Ensure the widget tree is initialized before Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the default options for the current platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Run the app
  runApp(const MainApp());
}

// MainApp is the root widget of the app
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp is the top-level widget that provides Material Design
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      home: Scaffold(
        appBar: AppBar(
            title: const Text(
                'Simple Voting App Using Firebase!')), // AppBar with a title
        body: CandidatesList(), // The body of the app is a list of candidates
      ),
    );
  }
}

// CandidatesList is a widget that displays a list of candidates
class CandidatesList extends StatelessWidget {
  // Reference to the 'candidates' collection in Firestore
  final CollectionReference candidatesCollection =
      FirebaseFirestore.instance.collection('candidates');

  CandidatesList({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder rebuilds the widget every time the stream emits a new value
    return StreamBuilder<QuerySnapshot>(
      // Listen to real-time updates from the 'candidates' collection
      stream: candidatesCollection.snapshots(),
      builder: (context, snapshot) {
        // Show a loading spinner while waiting for the data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        // If there's data, build a list of candidates
        else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              // For each candidate, create a CandidateTile widget
              return CandidateTile(
                doc: snapshot.data!.docs[index],
                candidatesCollection: candidatesCollection,
              );
            },
          );
        }
        // If there's no data, show a message
        else {
          return const Text('No data');
        }
      },
    );
  }
}

// CandidateTile is a widget that displays a single candidate
class CandidateTile extends StatelessWidget {
  final DocumentSnapshot doc; // The Firestore document of the candidate
  final CollectionReference
      candidatesCollection; // Reference to the 'candidates' collection

  const CandidateTile({
    super.key,
    required this.doc,
    required this.candidatesCollection,
  });

  @override
  Widget build(BuildContext context) {
    // Get the data from the document
    Map<String, dynamic>? dataMap = doc.data() as Map<String, dynamic>?;
    // If there's data, create a ListTile for the candidate
    if (dataMap != null) {
      MockBandInfo data = MockBandInfo.fromMap(dataMap);
      return ListTile(
        title: Text(data.name), // The name of the candidate
        trailing: Text(data.votes.toString()), // The number of votes
        onTap: () {
          // When the ListTile is tapped, increment the number of votes
          candidatesCollection
              .doc(doc.id)
              .update({'votes': FieldValue.increment(1)});
        },
      );
    }
    // If there's no data, show a message
    else {
      return const Text('Document has no data');
    }
  }
}
