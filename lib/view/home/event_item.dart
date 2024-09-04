import 'package:flutter/material.dart';
import 'package:udev_test_app/const/colors.dart';
import 'package:udev_test_app/model/event_model.dart';
import 'package:udev_test_app/view/details/details_view.dart';

class EventItem extends StatelessWidget {
  final EventModel event;
  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final color = event.priority == '1'
        ? blueColor
        : event.priority == '2'
            ? orangeColor
            : redColor;

    Flexible customChip([bool hasLocation = false]) {
      return Flexible(
        flex: hasLocation ? 3 : 2,
        child: ListTile(
          horizontalTitleGap: 0,
          leading: Icon(
            hasLocation ? Icons.location_on : Icons.access_time,
            size: 15,
            color: color,
          ),
          title: Text(hasLocation ? event.location! : event.time, maxLines: 1),
          titleTextStyle: TextStyle(color: color, fontSize: 10),
        ),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsView(id: event.id)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          border: Border(
            top: BorderSide(color: color, width: 10),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          ListTile(
            title: Text(event.name, maxLines: 1),
            subtitle: Text(event.description, maxLines: 2),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
            ),
            subtitleTextStyle: TextStyle(fontSize: 8, color: color),
          ),
          Row(
            children: [
              customChip(),
              if (event.location != null) customChip(true),
            ],
          )
        ]),
      ),
    );
  }
}
