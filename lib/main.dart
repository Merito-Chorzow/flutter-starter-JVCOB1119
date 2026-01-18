import 'package:flutter/material.dart';
import 'pages/entries_list.dart';
import 'pages/add_entry.dart';
import 'pages/entry_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Entries App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => EntriesList(),       // klasa z entries_list.dart
        '/add-entry': (context) => AddEntry(), // klasa z add_entry.dart
      },
      onGenerateRoute: (settings) {
        // obsługa szczegółów wpisu /entry/:id
        if (settings.name != null && settings.name!.startsWith('/entry/')) {
          final id = int.parse(settings.name!.replaceFirst('/entry/', ''));
          return MaterialPageRoute(
            builder: (context) => EntryDetail(entryId: id), // klasa z entry_detail.dart
          );
        }
        return null; // dla innych tras
      },
    );
  }
}
