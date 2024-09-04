import 'package:flutter/material.dart';
import 'package:udev_test_app/app.dart';
import 'package:udev_test_app/service/crud/crud_service.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await CRUDService().open();
  runApp(const MyApp());
}
