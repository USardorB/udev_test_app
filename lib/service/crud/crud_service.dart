import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:udev_test_app/model/event_model.dart';
import 'package:udev_test_app/service/crud/crud_constants.dart';

class CRUDService {
  static final CRUDService _shared = CRUDService._sharedInstance();
  CRUDService._sharedInstance() {
    _streamController = StreamController<List<EventModel>>.broadcast(
      onListen: () => _streamController.sink.add(_events),
    );
  }
  factory CRUDService() => _shared;

  Database? _db;
  List<EventModel> _events = [];

  late final StreamController<List<EventModel>> _streamController;

  Stream<List<EventModel>> get allEvents => _streamController.stream;

  Future<void> open() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, dbName);

    final db = await openDatabase(dbPath);
    _db = db;

    db.execute(createEventsTable);
    final allEvents = await getAllEvents();
    _events = allEvents.toList();
    _streamController.add(_events);
  }

  Future<void> createEvent(EventModel event) async {
    final db = _getDbOrThrow();

    final id = await db.insert(eventsTable, event.toMap());

    _events.add(event.copyWith(id: id));
    _streamController.add(_events);
  }

  Future<Iterable<EventModel>> getAllEvents() async {
    final db = _getDbOrThrow();
    final events = await db.query(eventsTable);
    return events.map((e) => EventModel.fromMap(e));
  }

  Future<void> updateEvent(EventModel event) async {
    final db = _getDbOrThrow();
    await db.update(
      eventsTable,
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
    _events.removeWhere((e) => e.id == event.id);
    _events.add(event);
    _streamController.add(_events);
  }

  Future<void> deleteEvent(int id) async {
    final db = _getDbOrThrow();
    final deletedCount = await db.delete(
      eventsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (deletedCount != 1) throw 'Error deleting event. Id: $id';
    _events.removeWhere((event) => event.id == id);
    _streamController.add(_events);
  }

  Future<EventModel> getEvent(int id) async {
    final db = _getDbOrThrow();
    final event = await db.query(
      eventsTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (event.length != 1) throw 'Something went wrong. Id: $id';
    return EventModel.fromMap(event.first);
  }

  Future<void> close() async {
    final db = _getDbOrThrow();
    await db.close();
    _db = null;
  }

  Database _getDbOrThrow() {
    final db = _db;
    if (db == null) throw 'Database not open';
    return db;
  }
}
