part of 'date_picker_bloc.dart';

abstract class DatePickerEvent {}

class SetDateEvent extends DatePickerEvent {
  final DateTime date;

  SetDateEvent(this.date);
}
