import 'package:flutter/material.dart';

import '../../../core/widgets/common_appbar.dart';
import '../../../core/widgets/no_item_found.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(),
      body: Center(child: NoItemFound(message: "No videos found")),
    );
  }
}
