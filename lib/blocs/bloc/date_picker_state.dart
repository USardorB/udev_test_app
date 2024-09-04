part of 'date_picker_bloc.dart';

final class DatePickerState {
  final DateTime selectedDate;
  final String dayMonthYear;
  final String dayOfWeek;
  final String month;

  DatePickerState(this.selectedDate)
      : dayMonthYear = _formatDayMonthYear(selectedDate),
        dayOfWeek = _formatDayOfWeek(selectedDate),
        month = _formatMonth(selectedDate);

  static String _formatDayMonthYear(DateTime date) =>
      '${date.day} ${_getMonthName(date.month)} ${date.year}';

  static String _formatDayOfWeek(DateTime date) =>
      _getDayOfWeekName(date.weekday);

  static String _formatMonth(DateTime date) => _getMonthName(date.month);

  static String _getMonthName(int month) => months[month - 1];

  static String _getDayOfWeekName(int dayOfWeek) => dayNames[dayOfWeek - 1];

  @override
  bool operator ==(covariant DatePickerState other) =>
      other.selectedDate == selectedDate;

  @override
  int get hashCode => selectedDate.hashCode;
}
