import 'package:flutter/material.dart';
import 'package:udev_test_app/const/colors.dart';
import 'package:udev_test_app/model/event_model.dart';
import 'package:udev_test_app/view/add_or_update/add_or_update_view.dart';
import 'package:udev_test_app/view/home/event_item.dart';

class DayEvents extends StatelessWidget {
  const DayEvents({super.key, required this.events, required this.date});
  final List<EventModel> events;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Schedule',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddOrUpdateView(date: date),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: blueColor,
              ),
              child: const Text(
                '+  Add Event',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 390),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventItem(event: event);
            },
          ),
        ),
      ],
    );
  }
}
