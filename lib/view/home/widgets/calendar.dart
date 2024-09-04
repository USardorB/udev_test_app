import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udev_test_app/blocs/bloc/date_picker_bloc.dart';
import 'package:udev_test_app/const/colors.dart';
import 'package:udev_test_app/const/day_names.dart';
import 'package:udev_test_app/model/event_model.dart';

class Calendar extends StatelessWidget {
  final DateTime currentDate;
  final Map<int, List<EventModel>> dayEvents;
  const Calendar({
    super.key,
    required this.currentDate,
    required this.dayEvents,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DatePickerBloc>().state;
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          state.month,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            IconButton.filled(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 15,
                color: Colors.black,
              ),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xffEFEFEF),
              ),
              onPressed: () {
                context.read<DatePickerBloc>().add(SetDateEvent(state
                    .selectedDate
                    .copyWith(month: state.selectedDate.month - 1)));
              },
            ),
            const SizedBox(width: 6),
            IconButton.filled(
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Colors.black,
              ),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xffEFEFEF),
              ),
              onPressed: () {
                context.read<DatePickerBloc>().add(SetDateEvent(state
                    .selectedDate
                    .copyWith(month: state.selectedDate.month + 1)));
              },
            ),
          ],
        )
      ]),
      const SizedBox(height: 18),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          dayNames.length,
          (index) {
            return Text(
              dayNames[index].substring(0, 3),
              style: const TextStyle(fontSize: 12, color: Color(0xff969696)),
            );
          },
        ),
      ),
      const SizedBox(height: 20),
      _buildDaysGrid(context),
    ]);
  }

  Widget _buildDaysGrid(BuildContext context) {
    final List<DateTime?> days = List.generate(42, (index) {
      final DateTime firstDayOfMonth =
          DateTime(currentDate.year, currentDate.month, 1);
      final int firstWeekday = firstDayOfMonth.weekday % 7;
      final int daysInMonth =
          DateUtils.getDaysInMonth(currentDate.year, currentDate.month);
      final int day = index - firstWeekday + 1;
      if (day > 0 && day <= daysInMonth) {
        return DateTime(currentDate.year, currentDate.month, day);
      }
      return null;
    });

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(35, (index) {
        final DateTime? date = days[index];
        final bool isToday = date != null &&
            date.day == currentDate.day &&
            date.month == currentDate.month &&
            date.year == currentDate.year;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              customBorder: const CircleBorder(),
              onTap: date != null
                  ? () {
                      context.read<DatePickerBloc>().add(SetDateEvent(date));
                    }
                  : null,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isToday ? blueColor : null,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  date != null ? date.day.toString() : '',
                  style: TextStyle(
                    color: isToday ? Colors.white : null,
                    fontSize: 12,
                    fontWeight: isToday ? FontWeight.w600 : null,
                  ),
                ),
              ),
            ),
            // if (isToday && !temp.containsValue(date.day))
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: List.generate(priorityColors.length, (index) {
            //       final priority = priorityColors.elementAt(index);
            //       return Container(
            //         margin: const EdgeInsets.only(right: 2),
            //         width: 6,
            //         height: 6,
            //         decoration: BoxDecoration(
            //           color: priority.keys.first == 1
            //               ? redColor
            //               : priority.keys.first == 2
            //                   ? orangeColor
            //                   : blueColor,
            //           shape: BoxShape.circle,
            //         ),
            //       );
            //     }),
            //   ),
          ],
        );
      }),
    );
  }
}
