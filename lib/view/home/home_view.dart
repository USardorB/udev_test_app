import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udev_test_app/blocs/bloc/date_picker_bloc.dart';
import 'package:udev_test_app/const/colors.dart';
import 'package:udev_test_app/model/event_model.dart';
import 'package:udev_test_app/service/crud/crud_service.dart';
import 'package:udev_test_app/view/home/widgets/calendar.dart';
import 'package:udev_test_app/view/home/widgets/day_events.dart';
import 'package:udev_test_app/view/home/widgets/title.dart';
import 'package:udev_test_app/view/notifications/notifications_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final crud = CRUDService();
    final state = context.watch<DatePickerBloc>().state;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const DateTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, NotificationsView.route());
            },
            icon: const Icon(Icons.notifications_rounded),
            style: IconButton.styleFrom(
              iconSize: 28,
            ),
          )
        ],
      ),
      body: StreamBuilder<List<EventModel>>(
          stream: crud.allEvents,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                final events = snapshot.data;

                // sorting events by time
                events?.sort((a, b) => a.time.compareTo(b.time));
                if (events != null) {
                  final monthEvents = events.where(
                    (event) =>
                        event.date.month == state.selectedDate.month &&
                        event.date.year == state.selectedDate.year,
                  );
                  // grouping events by day in Map<int, List<EventModel>> format
                  // where key is day and value is list of events for that day
                  final Map<int, List<EventModel>> dailyEvents = {};
                  for (var event in monthEvents) {
                    final day = event.date.day;
                    if (!dailyEvents.containsKey(day)) {
                      dailyEvents[day] = [];
                    }
                    dailyEvents[day]!.add(event);
                  }

                  // gettig todays events
                  final todaysEvents =
                      (dailyEvents[state.selectedDate.day] ?? [])
                        ..sort(
                          (a, b) => int.parse(a.time.substring(0, 1)).compareTo(
                            int.parse(b.time.substring(0, 1)),
                          ),
                        );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      children: [
                        Calendar(
                          currentDate: state.selectedDate,
                          dayEvents: dailyEvents,
                        ),
                        DayEvents(
                            events: todaysEvents, date: state.selectedDate),
                      ],
                    ),
                  );
                }
                return const CircularProgressIndicator();
              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }
}
