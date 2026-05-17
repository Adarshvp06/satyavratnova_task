import 'package:flutter/material.dart';

import '../../../core/widgets/common_appbar.dart';
import '../../../core/widgets/no_item_found.dart';

/// Dummy search screen displaying a search bar and a no items found state.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(),
      body: Center(child: NoItemFound(message: 'No results found')),
    );
  }
}
