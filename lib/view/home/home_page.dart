import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udev_test_app/blocs/bloc/date_picker_bloc.dart';
import 'package:udev_test_app/view/home/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatePickerBloc, DatePickerState>(
      builder: (context, state) {
        return const HomeView();
      },
    );
  }
}
