import 'package:bloc/bloc.dart';
import 'package:udev_test_app/const/day_names.dart';

part 'date_picker_state.dart';
part 'date_picker_event.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(DatePickerState(DateTime.now())) {
    on<SetDateEvent>(_onSetDate);
  }

  void _onSetDate(SetDateEvent event, Emitter<DatePickerState> emit) {
    emit(DatePickerState(event.date));
  }
}
