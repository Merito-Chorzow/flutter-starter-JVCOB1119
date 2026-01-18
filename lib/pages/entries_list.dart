import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EntriesList extends StatefulWidget {
  const EntriesList({super.key});

  @override
  State<EntriesList> createState() => _EntriesListState();
}

class _EntriesListState extends State<EntriesList> {
  List<dynamic> entries = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchEntries();
  }

  Future<void> fetchEntries() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      entries = await ApiService.fetchEntries();
    } catch (e) {
      setState(() {
        error = e.toString();
      });
      // debug w konsoli
      // ignore: avoid_print
      print('Błąd fetchEntries: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _openDetails(dynamic entry) async {
    final result = await Navigator.pushNamed(context, '/entry/${entry['id']}');
    if (result == true) {
      fetchEntries();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (isLoading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (error != null) {
      // Błąd + przycisk ponów
      body = Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: fetchEntries,
                icon: const Icon(Icons.refresh),
                label: const Text('Spróbuj ponownie'),
              ),
            ],
          ),
        ),
      );
    } else if (entries.isEmpty) {
      // Pusty stan
      body = const Center(child: Text('Brak wpisów'));
    } else {
      body = RefreshIndicator(
        onRefresh: fetchEntries,
        child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];

            final title = (entry['title'] ?? '').toString();
            final dateRaw = (entry['date'] ?? '').toString();
            final lat = entry['lat'];
            final lng = entry['lng'];

            // proste "skrócenie" ISO daty -> yyyy-mm-dd (jeśli jest)
            final dateShort = dateRaw.length >= 10 ? dateRaw.substring(0, 10) : dateRaw;

            final hasLocation = lat != null && lng != null;

            return ListTile(
              title: Text(title.isEmpty ? '(bez tytułu)' : title),
              subtitle: Text(
                hasLocation
                    ? 'Data: $dateShort • GPS: ${lat.toString()}, ${lng.toString()}'
                    : 'Data: $dateShort • GPS: brak',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _openDetails(entry),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Lista wpisów')),
      body: body,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add-entry');
          if (result == true) fetchEntries();
        },
      ),
    );
  }
}
