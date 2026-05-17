import 'package:flutter/material.dart';
import 'package:satyavratnova_task/core/theme/theme_extension.dart';
import 'package:satyavratnova_task/core/widgets/common_appbar.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Center(child: Text("Create Your Post", style: context.titleMedium)),
    );
  }
}
