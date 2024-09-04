import 'package:flutter/material.dart';
import 'package:udev_test_app/model/event_model.dart';

class MainInformationSection extends StatelessWidget {
  const MainInformationSection({
    super.key,
    required this.color,
    required this.event,
  });

  final Color color;
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(event.name),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Text(event.description),
            subtitleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 16),
              const Icon(Icons.alarm, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(event.time,
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 16),
              const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(event.location ?? 'Not specified',
                  style: const TextStyle(color: Colors.white, fontSize: 14))
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
