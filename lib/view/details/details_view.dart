import 'package:flutter/material.dart';
import 'package:udev_test_app/const/colors.dart';
import 'package:udev_test_app/model/event_model.dart';
import 'package:udev_test_app/service/crud/crud_service.dart';
import 'package:udev_test_app/view/add_or_update/add_or_update_view.dart';
import 'package:udev_test_app/view/details/main_info_widget.dart';

class DetailsView extends StatelessWidget {
  final int id;
  const DetailsView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final crud = CRUDService();

    return FutureBuilder(
        future: crud.getEvent(id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                final event = snapshot.data as EventModel;
                final color = event.priority == '1'
                    ? blueColor
                    : event.priority == '2'
                        ? orangeColor
                        : redColor;

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: color,
                    leadingWidth: 80,
                    leading: IconButton.filled(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    actions: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddOrUpdateView(id: id),
                            ),
                          );
                        },
                        label: const Text('Edit'),
                        icon: const Icon(Icons.edit_rounded, size: 18),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  body: Column(
                    children: [
                      MainInformationSection(color: color, event: event),
                      Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Reminder',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              'Not specified',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff7C7B7B),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              event.description,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xff999999),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.42,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: ElevatedButton.icon(
                    label: const Text(
                      'Delete Event',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () {
                      crud.deleteEvent(id);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: redColor,
                      backgroundColor: redColor.withOpacity(0.2),
                      elevation: 0,
                      fixedSize:
                          Size(MediaQuery.sizeOf(context).width - 36, 56),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const CircularProgressIndicator();
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
