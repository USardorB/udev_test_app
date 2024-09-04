import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const NotificationsView());
  }

  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const Center(child: Text('No notifications')),
    );
  }
}
