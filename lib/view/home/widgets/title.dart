import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udev_test_app/blocs/bloc/date_picker_bloc.dart';

class DateTitle extends StatelessWidget {
  const DateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DatePickerBloc>().state;

    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(1950),
          lastDate: DateTime(2950),
        );
        if (date != null) {
          context.read<DatePickerBloc>().add(SetDateEvent(date));
        }
      },
      child: Column(children: [
        Text(
          state.dayOfWeek,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.dayMonthYear, style: const TextStyle(fontSize: 10)),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
          ],
        ),
      ]),
    );
  }
}
