import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EntryDetail extends StatefulWidget {
  final int entryId;

  const EntryDetail({super.key, required this.entryId});

  @override
  State<EntryDetail> createState() => _EntryDetailState();
}

class _EntryDetailState extends State<EntryDetail> {
  late Future<Map<String, dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchEntry(widget.entryId);
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Usunąć wpis?'),
        content: const Text('Tej operacji nie da się cofnąć.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Anuluj')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Usuń')),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await ApiService.deleteEntry(widget.entryId);
      if (mounted) Navigator.pop(context, true); // wracamy i odświeżamy listę
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Szczegóły wpisu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _delete,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final entry = snapshot.data;
            if (entry == null) return const Center(child: Text('Brak danych wpisu'));

            final title = (entry['title'] ?? '').toString();
            final description = (entry['description'] ?? '').toString();
            final date = (entry['date'] ?? '').toString();

            final lat = entry['lat'];
            final lng = entry['lng'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (date.isNotEmpty) Text('Data: $date'),
                const SizedBox(height: 12),
                Text(description),
                const SizedBox(height: 12),
                if (lat != null && lng != null)
                  Text('Lokalizacja: $lat, $lng')
                else
                  const Text('Lokalizacja: brak'),
              ],
            );
          },
        ),
      ),
    );
  }
}
