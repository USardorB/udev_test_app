import 'package:flutter/material.dart';
import 'package:udev_test_app/const/colors.dart';
import 'package:udev_test_app/model/event_model.dart';
import 'package:udev_test_app/service/crud/crud_service.dart';

class AddOrUpdateView extends StatefulWidget {
  final DateTime? date;
  final int? id;
  const AddOrUpdateView({super.key, this.date, this.id});

  @override
  State<AddOrUpdateView> createState() => _AddOrUpdateViewState();
}

class _AddOrUpdateViewState extends State<AddOrUpdateView> {
  late final TextEditingController _name;
  late final TextEditingController _desciption;
  late final TextEditingController _location;
  late final TextEditingController _priority;
  late final TextEditingController _time;
  final CRUDService crud = CRUDService();
  int? id;
  Future<void> _addOrUpdate() async {
    if (widget.id != null) {
      id = widget.id;
      final event = await crud.getEvent(widget.id!);
      _name.text = event.name;
      _desciption.text = event.description;
      _location.text = event.location ?? '';
      _priority.text = event.priority.toString();
      _time.text = event.time;
    }
  }

  bool shouldDeleteIfEmpty() =>
      _name.text.isEmpty || _desciption.text.isEmpty || _time.text.isEmpty;

  @override
  void initState() {
    _name = TextEditingController();
    _desciption = TextEditingController();
    _location = TextEditingController();
    _priority = TextEditingController(text: '2');
    _time = TextEditingController();
    _addOrUpdate();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _desciption.dispose();
    _location.dispose();
    _priority.dispose();
    _time.dispose();
    super.dispose();
  }

  Future<TimeOfDay?> timePicker() async => await showTimePicker(
        barrierDismissible: false,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        ),
        initialEntryMode: TimePickerEntryMode.inputOnly,
        context: context,
        initialTime: const TimeOfDay(hour: 00, minute: 00),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Event name'),
            TextField(
              controller: _name,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 14),
            const Text('Event Description'),
            TextField(
              controller: _desciption,
              minLines: 5,
              maxLines: 5,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 14),
            const Text('Event Location'),
            TextField(
              controller: _location,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.location_on, color: blueColor),
              ),
            ),
            const SizedBox(height: 14),
            const Text('Priority color'),
            SizedBox(
              width: 75,
              child: DropdownButtonFormField<String>(
                value: _priority.text,
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                borderRadius: BorderRadius.circular(8),
                items: [
                  DropdownMenuItem(
                    value: '1',
                    child: Container(color: blueColor, width: 24, height: 20),
                  ),
                  DropdownMenuItem(
                    value: '2',
                    child: Container(color: orangeColor, width: 24, height: 20),
                  ),
                  DropdownMenuItem(
                    value: '3',
                    child: Container(color: redColor, width: 24, height: 20),
                  ),
                ],
                onChanged: (value) {
                  _priority.text = value ?? '2';
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 14),
            const Text('Event Time'),
            TextField(
              keyboardType: TextInputType.none,
              controller: _time,
              onTap: () async {
                final startTime = await timePicker();
                final endTime = await timePicker();
                if (startTime != null && endTime != null) {
                  _time.text =
                      '${startTime.format(context)} - ${endTime.format(context)}';
                }
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (shouldDeleteIfEmpty()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Event name, description, location and time can\'t be empty.',
                    ),
                  ));
                  return;
                }
                if (id != null) {
                  final old = await crud.getEvent(widget.id!);
                  crud.updateEvent(
                    EventModel(
                      id: id!,
                      name: _name.text,
                      description: _desciption.text,
                      location: _location.text,
                      priority: _priority.text,
                      time: _time.text,
                      date: old.date,
                    ),
                  );
                } else {
                  crud.createEvent(EventModel(
                    id: 0,
                    name: _name.text,
                    description: _desciption.text,
                    location: _location.text.isEmpty ? null : _location.text,
                    priority: _priority.text,
                    time: _time.text,
                    date: widget.date!,
                  ));
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: blueColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: const Size(370, 50),
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
