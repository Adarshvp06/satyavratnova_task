import 'package:flutter/material.dart';
import 'package:satyavratnova_task/core/theme/theme_extension.dart';

import '../../../core/widgets/common_appbar.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Center(
        child: Text("Brand (BN) Screen", style: context.titleMedium),
      ),
    );
  }
}
