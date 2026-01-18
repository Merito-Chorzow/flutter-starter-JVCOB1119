import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/api_service.dart';

class AddEntry extends StatefulWidget {
  const AddEntry({super.key});

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';

  bool isSaving = false;
  bool isLocating = false;
  String? error;

  double? lat;
  double? lng;

  Future<void> _getLocation() async {
    setState(() {
      isLocating = true;
      error = null;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Usługa lokalizacji jest wyłączona. Włącz GPS i spróbuj ponownie.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw Exception('Brak zgody na lokalizację (odmowa).');
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Lokalizacja zablokowana na stałe. Zmień to w ustawieniach aplikacji.');
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );

      setState(() {
        lat = pos.latitude;
        lng = pos.longitude;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pobrano lokalizację ✅')),
        );
      }
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      setState(() => isLocating = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      isSaving = true;
      error = null;
    });

    try {
      await ApiService.createEntry({
        'title': title,
        'description': description,
        'date': DateTime.now().toIso8601String(),
        'lat': lat,
        'lng': lng,
      });

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationText = (lat != null && lng != null)
        ? '${lat!.toStringAsFixed(5)}, ${lng!.toStringAsFixed(5)}'
        : 'Brak (kliknij "Pobierz lokalizację")';

    return Scaffold(
      appBar: AppBar(title: const Text('Dodaj wpis')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tytuł'),
                onSaved: (v) => title = v ?? '',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Wymagane' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Opis'),
                minLines: 2,
                maxLines: 5,
                onSaved: (v) => description = v ?? '',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Wymagane' : null,
              ),
              const SizedBox(height: 16),

              // Natywna funkcja: GPS
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Lokalizacja (GPS)'),
                subtitle: Text(locationText),
                trailing: ElevatedButton.icon(
                  onPressed: isLocating ? null : _getLocation,
                  icon: isLocating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.my_location),
                  label: const Text('Pobierz'),
                ),
              ),

              const SizedBox(height: 12),
              if (error != null)
                Text(
                  error!,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isSaving ? null : _save,
                child: isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Zapisz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
