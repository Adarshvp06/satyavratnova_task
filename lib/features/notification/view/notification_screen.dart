import 'package:flutter/material.dart';
import 'package:satyavratnova_task/core/widgets/common_appbar.dart';
import 'package:satyavratnova_task/core/widgets/no_item_found.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(),
      body: Center(child: NoItemFound(message: "No notifications yet")),
    );
  }
}
