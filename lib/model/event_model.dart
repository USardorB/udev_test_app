import 'package:udev_test_app/service/crud/crud_constants.dart';

class EventModel {
  final int id;
  final String name;
  final String description;
  final String? location;
  final String priority;
  final String time;
  final DateTime date;

  EventModel({
    required this.id,
    required this.name,
    required this.description,
    this.location,
    required this.priority,
    required this.time,
    required this.date,
  });

  // Create a copyWith

  EventModel copyWith({
    int? id,
    String? name,
    String? description,
    String? location,
    String? priority,
    String? time,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      priority: priority ?? this.priority,
      time: time ?? this.time,
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      nameColumn: name,
      descriptionColumn: description,
      locationColumn: location,
      priorityColumn: priority,
      timeColumn: time,
      dateColumn: date.toIso8601String(),
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map[idColumn],
      name: map[nameColumn],
      description: map[descriptionColumn],
      location: map[locationColumn],
      priority: map[priorityColumn],
      time: map[timeColumn],
      date: DateTime.parse(map[dateColumn]),
    );
  }
}
