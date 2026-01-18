class Entry {
  final int? id;
  final String title;
  final String description;
  final double? latitude;
  final double? longitude;
  final String? imageUrl;
  final DateTime createdAt;

  Entry({
    this.id,
    required this.title,
    required this.description,
    this.latitude,
    this.longitude,
    this.imageUrl,
    required this.createdAt,
  });

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
